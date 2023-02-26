; # [ zrfisaac ]

; # [ about ]
; # - author : Isaac Santana
; # . - email : zrfisaac@gmail.com
; # . - site : zrfisaac.github.io

; # [ nsis ]

; # - config
!define c_architecture "x32"
!define c_name "bde"
!define c_path "$PROGRAMFILES\Common Files\Borland Shared\BDE"
!define c_title "BDE"
!define c_version "5.2.0.2"

; # - library
!include "MUI2.nsh"
!include "x64.nsh"

; # - general
Name "${c_title} ${c_version}"
OutFile "output\${c_name}_${c_version}_${c_architecture}_installer.exe"
Unicode True
InstallDir "${c_path}"
InstallDirRegKey HKLM "SOFTWARE\${c_name}" ""
RequestExecutionLevel admin

; # - picture
!define MUI_ICON "media\logo-01.ico" 
!define MUI_UNICON "media\logo-01.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "media\header-02.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "media\header-02.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "media\header-01.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "media\header-01.bmp"

; # - shortcut
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "$(MUI_Shortcut)"
!define MUI_FINISHPAGE_RUN_FUNCTION "fnShortcut"
Function "fnShortcut"
	CreateShortCut "$DESKTOP\${c_title}.lnk" "$INSTDIR\bdeadmin.exe"
FunctionEnd

; # - interface
!define MUI_ABORTWARNING

; # - page - install
!insertmacro MUI_PAGE_WELCOME
;!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; # - page - uninstall
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; # - language
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "PortugueseBR"
Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

; # - translation
LangString MUI_Shortcut ${LANG_ENGLISH} "Create desktop shortcut"
LangString MUI_Shortcut ${LANG_PORTUGUESEBR} "Criar atalho na área de trabalho"

; # - install - BDE
Section BDE
	; # : - required
	SectionIn RO

	; # : - file
	SetOutPath "$INSTDIR"
	File "resource\dll\*.*"
	File "resource\binary\*.*"

	;# : system
	${If} ${RunningX64}
		SetOutPath "C:\Windows\SysWOW64"
	${Else}
		SetOutPath "C:\Windows\System32"
	${EndIf}
	File "resource\system32\*.bpl"
	File "resource\system32\*.cpl"
	File "resource\system32\*.dll"
	File "resource\system32\*.lic"
	File "resource\system32\*.ocx"
	File "resource\system32\*.vtd"

	; # : - registry
	WriteRegStr HKLM "SOFTWARE\BDE" "" $INSTDIR

	; # : - uninstaller
	WriteUninstaller "$INSTDIR\Uninstall.exe"

	; # : - menu
	CreateDirectory "$SMPROGRAMS\"
	CreateShortCut "$SMPROGRAMS\${c_title}.lnk" "$INSTDIR\bdeadmin.exe" "" "$INSTDIR\bdeadmin.ico"

	; # : - control panel
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "DisplayName" "${c_title} ${c_version}"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "DisplayIcon" "$\"$INSTDIR\logo.ico$\""
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "Publisher" "zrfisaac"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "HelpLink" "https://github.com/zrfisaac/install.bde"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "URLUpdateInfo" "https://github.com/zrfisaac/install.bde"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "URLInfoAbout" "https://github.com/zrfisaac/install.bde"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "DisplayVersion" "${c_version}"
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "VersionMajor" 5
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "VersionMinor" 2
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "NoModify" 0
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "NoRepair" 2
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}" "EstimatedSize" 46227 ;KB

	; # : - registry
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

; # - uninstall - BDE
Section Un.BDE
	; # : - required
	SectionIn RO

	; # : - file
	Delete "$INSTDIR\*.*"
	RMDir /r "$INSTDIR"

	; # : - menu
	Delete "$INSTDIR\${c_title}.lnk"
	RMDir /r "$SMPROGRAMS\${c_title}"

	; # : - registry
	DeleteRegKey HKLM "SOFTWARE\${c_title}"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${c_title}"
SectionEnd
