; # [ zrfisaac ]

; # [ sobre ]
; # - autor : Isaac Santana
; # . - email : zrfisaac@gmail.com
; # . - site : zrfisaac.github.io

; # [ innosetup ]

; # : - vairavel
;#define vAppNome "ZRFI"
;#define vAppVersao "0.0"
#define AppNome "Servidor Relatorios Maker"
#define AppVersao "5.0.0.21"
#define AppAutor "Softwell Solutions"
#define AppUrl "http://www.softwell.com.br"
#define AppSuporte "https://suporte.softwell.com.br"
#define AppUpdate "https://manual.softwell.com.br/#/historico/alteracoes_maker5"

#define ServicoArquivo "ReportServer.exe"
#define ServicoNome "SoftwellReportServer"
#define ServicoDescricao "Servidor Relatorios Maker Softwell Solutions http://www.softwell.com.br"

#define LocalBinario "C:\Webrun\reports"
#define LocalDestino "Softwell Solutions\Servidor de Relatorios\50"
;#define LocalContrato "D:\InnoSetup Projects\contrato.txt"
#define LocalIcone "..\maker"

#define IconePadrao "mainicon.ico"


#define SaidaCaminho "."

; # : - innosetup - setup
;[Setup]
;AppId={{930B3F23-43B2-4A58-8910-A4D841FB4BDE}
;AppName={#vAppNome}
;AppVersion={#vAppVersao}
;DefaultDirName={localappdata}\_
;OutputBaseFilename=_.exe
;OutputDir=.
; PrivilegesRequired=lowest

[Setup]
AppId={{0CD85CEF-27E8-4280-9D71-DB442FEC699C}
AppName={#AppNome} {#AppVersao}
AppVersion={#AppVersao}
AppVerName={#AppNome} {#AppVersao}
AppPublisher={#AppAutor}
AppPublisherURL={#AppUrl}
AppSupportURL={#AppSuporte}
AppUpdatesURL={#AppUpdate}
DefaultDirName={commonpf}\{#LocalDestino}
OutputDir={#SaidaCaminho}
OutputBaseFilename={#AppNome} {#AppVersao} x64
Compression=lzma
SolidCompression=yes
;LicenseFile={#LocalContrato}
ChangesAssociations=yes
CloseApplications=force
SetupIconFile={#LocalIcone}\{#IconePadrao}
UninstallDisplayIcon={commonpf}\{#LocalDestino}\{#IconePadrao}
WizardImageFile=sidebar.bmp
WizardSmallImageFile=icon.bmp
DisableWelcomePage=no

; # [ pascal ]
[Code]
