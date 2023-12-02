.686
.model flat, stdcall
option casemap: none

include Template.inc

.code
start:
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL
	
DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szDialogCaption
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
		
		invoke SetTimer,hWnd,0,100,0
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		.if eax == IDC_EXIT
			invoke SendMessage, hWnd, WM_CLOSE,0, 0
		.endif
	.elseif uMsg == WM_TIMER
		invoke GetSystemPowerStatus, addr sps 	
		mov al, sps.SYSTEM_POWER_STATUS.ACLineStatus
		.if al == 0
			invoke SetDlgItemText, hWnd, IDC_ACINFO, addr offline
		.elseif al == 1	
			invoke SetDlgItemText, hWnd, IDC_ACINFO, addr online
		.else
			invoke SetDlgItemText, hWnd, IDC_ACINFO, addr unknown
		.endif		
		mov al, sps.SYSTEM_POWER_STATUS.BatteryFlag
		.if al ==1
			invoke SetDlgItemText, hWnd, IDC_BAT, addr BatHigh
		.elseif al == 2
			invoke SetDlgItemText, hWnd, IDC_BAT, addr BatLow
		.elseif al == 4
			invoke SetDlgItemText, hWnd, IDC_BAT, addr BatCrit
		.elseif eax == 8
			invoke SetDlgItemText, hWnd, IDC_BAT, addr BatCharge
		.elseif eax == 128
			invoke SetDlgItemText, hWnd, IDC_BAT, addr NoBat
		.else
			invoke SetDlgItemText, hWnd, IDC_BAT, addr unknown
		.endif	
		
		mov al,sps.SYSTEM_POWER_STATUS.BatteryLifePercent
		.if al != 255
			invoke SendDlgItemMessage, hWnd, IDC_PB,PBM_SETPOS, addr BatLife,0
		.endif
	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, 0
	.endif
	
	xor eax, eax			
	Ret
DlgProc EndP	
end start
