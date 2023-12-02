
include windows.inc
include kernel32.inc
include user32.inc
include comctl32.inc

includelib kernel32.lib
includelib user32.lib
includelib comctl32.lib

DlgProc	proto	:HWND, :UINT, :WPARAM, :LPARAM

.data
szDialogCaption	db	"Power Status Info 0.1 beta 1 by Lahar",0
online		db	"Online",0
offline		db	"Offline",0
unknown		db	"Unknown Status"

BatHigh		db	"High",0
BatLow		db	"Low",0
BatCrit		db	"Critical",0
BatCharge	db	"Charging",0
NoBat		db	"No System Battery",0
BatFormat	db	"%d",0

.data?
hInstance	HINSTANCE ?
sps	SYSTEM_POWER_STATUS <>
BatLife		dd	?

.const
IDD_DLGBOX	equ	1001
IDC_EXIT	equ	1002
IDC_ACINFO	equ	1003
IDC_BAT		equ	1005
IDC_PB		equ	1008
IDC_LB1		equ	1010
APP_ICON	equ	2000

