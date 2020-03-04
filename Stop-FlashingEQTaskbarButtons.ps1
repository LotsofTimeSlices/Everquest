#Forces EQ taskbar buttons to flash continuously and then stops them.  If the button has finished flashing, it will glow orange continuously and cannot be easily changed.  Therefore, the buttons are all forced to flash so they can be stopped.
#https://learn-powershell.net/2013/08/26/make-a-window-flash-in-taskbar-using-powershell-and-pinvoke/
Add-Type -TypeDefinition @"
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

public class Window
{
    [StructLayout(LayoutKind.Sequential)]
    public struct FLASHWINFO
    {
        public UInt32 cbSize;
        public IntPtr hwnd;
        public UInt32 dwFlags;
        public UInt32 uCount;
        public UInt32 dwTimeout;
    }

    //Stop flashing. The system restores the window to its original state. 
    const UInt32 FLASHW_STOP = 0;
    //Flash the window caption. 
    const UInt32 FLASHW_CAPTION = 1;
    //Flash the taskbar button. 
    const UInt32 FLASHW_TRAY = 2;
    //Flash both the window caption and taskbar button.
    //This is equivalent to setting the FLASHW_CAPTION | FLASHW_TRAY flags. 
    const UInt32 FLASHW_ALL = 3;
    //Flash continuously, until the FLASHW_STOP flag is set. 
    const UInt32 FLASHW_TIMER = 4;
    //Flash continuously until the window comes to the foreground. 
    const UInt32 FLASHW_TIMERNOFG = 12; 


    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    static extern bool FlashWindowEx(ref FLASHWINFO pwfi);

    public static bool FlashWindow(IntPtr handle, UInt32 timeout, UInt32 count)
    {
        IntPtr hWnd = handle;
        FLASHWINFO fInfo = new FLASHWINFO();

        fInfo.cbSize = Convert.ToUInt32(Marshal.SizeOf(fInfo));
        fInfo.hwnd = hWnd;
        fInfo.dwFlags = FLASHW_ALL | FLASHW_TIMERNOFG;
        fInfo.uCount = count;
        fInfo.dwTimeout = timeout;

        return FlashWindowEx(ref fInfo);
    }
}
"@

#https://www.displayfusion.com/ScriptedFunctions/View/?ID=42d44f29-df41-4c4e-872b-fa5181551cf2
Add-Type -TypeDefinition @"
using System;
using System.Drawing;
using System.Runtime.InteropServices;

// The 'windowHandle' parameter will contain the window handle for the:
// - Active window when run by hotkey
// - Window Location target when run by a Window Location rule
// - TitleBar Button owner when run by a TitleBar Button
// - Jump List owner when run from a Taskbar Jump List
// - Currently focused window if none of these match
public static class DisplayFusionFunction
{
	public static void Run(IntPtr windowHandle)
	{
		ScriptHelper.EnumWindows(EnumWindowsCallback);
	}

	public static bool EnumWindowsCallback(IntPtr windowHandle, IntPtr lParam)
	{
		ScriptHelper.DisableWindowFlash(windowHandle);
		return true;
	}
}

public static class ScriptHelper
{
	public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

	[DllImport("user32.dll")]
	[return: MarshalAs(UnmanagedType.Bool)]
	private static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);

	[DllImport("user32.dll")]
	[return: MarshalAs(UnmanagedType.Bool)]
	private static extern bool FlashWindowEx(ref FLASHWINFO pwfi);

	//Stop flashing. The system restores the window to its original state. 
	public const UInt32 FLASHW_STOP = 0; 

	[StructLayout(LayoutKind.Sequential)]
	private struct FLASHWINFO
	{
		public UInt32 cbSize;
		public IntPtr hwnd;
		public UInt32 dwFlags;
		public UInt32 uCount;
		public UInt32 dwTimeout;
	}

	public static bool EnumWindows(EnumWindowsProc enumProc)
	{
		return EnumWindows(enumProc, IntPtr.Zero);
	}

	public static bool DisableWindowFlash(IntPtr windowHandle)
	{
		FLASHWINFO fInfo = new FLASHWINFO();
		fInfo.cbSize = Convert.ToUInt32(Marshal.SizeOf(fInfo));
		fInfo.hwnd = windowHandle;
		fInfo.dwFlags = FLASHW_STOP;
		fInfo.uCount = 0;
		fInfo.dwTimeout = 0;
		return FlashWindowEx(ref fInfo);
	}
}
"@


$handles = (Get-Process -Name eqgame)| Select-Object -ExpandProperty MainWindowHandle
foreach ($handle in $handles) #Flash all EQ Windows
{
    [window]::FlashWindow($handle,150,0)
}

foreach ($handle in $handles) #Stop all flashing EQ Windows
{   
    [DisplayFusionFunction]::Run($handle)
}

#Other links
#https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-flashwinfo?redirectedfrom=MSDN
#https://stackoverflow.com/questions/21987/flashwindowex-flashw-stop-still-keeps-taskbar-colored
