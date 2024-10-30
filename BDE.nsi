; # [ zrfisaac ]

; # [ about ]
; # - author : Isaac Santana
; # . - email : zrfisaac@gmail.com
; # . - site : zrfisaac.github.io

; # [ nsis ]

; # - Biblioteca
!include "MUI2.nsh"
!include "x64.nsh"

; # - Geral
Name "BDE 5.2.0.2"
OutFile "Output\BDE 5.2.0.2.exe"
Unicode True
InstallDir "$PROGRAMFILES\Common Files\Borland Shared\BDE"
InstallDirRegKey HKLM "SOFTWARE\BDE" ""
RequestExecutionLevel Admin

; # - Pictures
!define MUI_ICON "Pictures\Installer.ico" 
!define MUI_UNICON "Pictures\Uninstaller.ico" 
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "Pictures\InstallerHeader.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Pictures\InstallerBanner.bmp"
!define MUI_HEADERIMAGE_UNBITMAP  "Pictures\UninstallerHeader.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "Pictures\UninstallerBanner.bmp"

; # - Shortcuts
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "$(MUI_Shortcut)"
!define MUI_FINISHPAGE_RUN_FUNCTION "fnShortcut"
Function "fnShortcut"
	CreateShortCut "$DESKTOP\BDE.lnk" "$INSTDIR\bdeadmin.exe"
FunctionEnd

; # - Interface
!define MUI_ABORTWARNING

; # - Page - Installer
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; # - Page - Uninstaller
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; # - Language
!insertmacro MUI_LANGUAGE "PortugueseBR"
Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

; # - Version
VIProductVersion "5.2.0.2"
VIAddVersionKey "ProductName" "BDE"
VIAddVersionKey "Comments" ""
VIAddVersionKey "CompanyName" "Borland"
VIAddVersionKey "LegalTrademarks" "Borland"
VIAddVersionKey "LegalCopyright" "Borland"
VIAddVersionKey "FileDescription" "BDE"
VIAddVersionKey "FileVersion" "5.2.0.2"
VIAddVersionKey "ProductVersion" "5.2.0.2"

; # - Translation
LangString MUI_Shortcut ${LANG_PORTUGUESEBR} "Criar atalho na área de trabalho"

; # - Installer - BDE
Section BDE
	; # : - Required
	SectionIn RO

	; # : - Files
	SetOutPath "$INSTDIR"
	File "DLLs\ntwdblib.dll"
	File "Resources\Program Files (x86)\Common Files\Borland Shared\BDE\*.*"

	; # : - Uninstaller
	WriteUninstaller "$INSTDIR\Uninstall.exe"

	; # : - Shortcuts
	CreateDirectory "$SMPROGRAMS\"
	CreateShortCut "$SMPROGRAMS\BDE.lnk" "$INSTDIR\bdeadmin.exe" "" "$INSTDIR\bdeadmin.ico"

	; # : - Control Panel
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "DisplayName" "BDE 5.2.0.2"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "QuietUninstallString" "$\"$INSTDIR\Uninstall.exe$\" /S"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "DisplayIcon" "$\"$INSTDIR\bdeadmin.ico$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "Publisher" "Borland"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "DisplayVersion" "5.2.0.2"
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "VersionMajor" 5
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "VersionMinor" 2
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "NoModify" 0
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "NoRepair" 2
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE" "EstimatedSize" 46227 ;KB

	; # : - Registry
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine" "CONFIGFILE01" "$INSTDIR\IDAPI32.CFG"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine" "DLLPath" "$INSTDIR\"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine" "RESOURCE" "0009"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine" "SaveConfig" "WIN32"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine" "UseCount" "1"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "DATABASE NAME" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SERVER NAME" "MSS_SERVER"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "USER NAME" "MYNAME"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "OPEN MODE" "READ/WRITE"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SCHEMA CACHE SIZE" "8"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "BLOB EDIT LOGGING" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "LANGDRIVER" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SQLQRYMODE" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SQLPASSTHRU MODE" "SHARED AUTOCOMMIT"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "DATE MODE" "0"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SCHEMA CACHE TIME" "-1"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "MAX QUERY TIME" "300"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "MAX ROWS" "-1"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "BATCH COUNT" "200"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "ENABLE SCHEMA CACHE" "FALSE"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "SCHEMA CACHE DIR" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "HOST NAME" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "APPLICATION NAME" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "NATIONAL LANG NAME" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "ENABLE BCD" "FALSE"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "TDS PACKET SIZE" "4096"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "BLOBS TO CACHE" "64"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\DB OPEN" "BLOB SIZE" "32"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "VERSION" "4.0"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "TYPE" "SERVER"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "DLL32" "SQLMSS32.DLL"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "VENDOR INIT" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "CONNECT TIMEOUT" "60"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "TIMEOUT" ""
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "DRIVER FLAGS" "300"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "TRACE MODE" "0"
	WriteRegStr HKLM "SOFTWARE\Borland\Database Engine\Settings\DRIVERS\MSSQL\INIT" "MAX DBPROCESSES" "31"
SectionEnd

; # - Uninstaller - BDE
Section Un.BDE
	; # : - Required
	SectionIn RO

	; # : - Files
	Delete "$INSTDIR\*.*"
	RMDir /r "$INSTDIR"

	; # : - Shortcuts
	Delete "$INSTDIR\BDE.lnk"
	RMDir /r "$SMPROGRAMS\BDE"

	; # : - Registry
	DeleteRegKey HKLM "SOFTWARE\BDE"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BDE"
SectionEnd
