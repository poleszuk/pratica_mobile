program ProjectMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitSplash in 'UnitSplash.pas' {FormSplash},
  u99Permissions in 'Units\u99Permissions.pas',
  UnitPincipal in 'UnitPincipal.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSplash, FormSplash);
  Application.Run;
end.
