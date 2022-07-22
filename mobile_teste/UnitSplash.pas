unit UnitSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.TabControl,
  FMX.Ani, System.Actions, FMX.ActnList, u99Permissions,
  FMX.MediaLibrary.Actions,

  {$IFDEF ANDROID}
    FService : IFMXVirtualKeyboardService;
  {$ENDIF}

 FMX.StdActns;

type
  TFormSplash = class(TForm)
    Layout2: TLayout;
    ImgLoginLogo: TImage;
    Layout1: TLayout;
    RoundRect1: TRoundRect;
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    Layout3: TLayout;
    RoundRect2: TRoundRect;
    Edit2: TEdit;
    Layout4: TLayout;
    RoundRect3: TRoundRect;
    rect_login: TLabel;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabConta: TTabItem;
    Layout5: TLayout;
    Image1: TImage;
    Layout6: TLayout;
    RoundRect4: TRoundRect;
    Edit3: TEdit;
    Layout7: TLayout;
    RoundRect5: TRoundRect;
    Edit4: TEdit;
    Layout8: TLayout;
    RoundRect6: TRoundRect;
    Label2: TLabel;
    Layout9: TLayout;
    RoundRect7: TRoundRect;
    Edit5: TEdit;
    TabFoto: TTabItem;
    Layout10: TLayout;
    Layout13: TLayout;
    RoundRect10: TRoundRect;
    Label3: TLabel;
    Layout11: TLayout;
    c_foto_editar: TCircle;
    TabEscolher: TTabItem;
    Layout12: TLayout;
    FloatAnimation1: TFloatAnimation;
    Label4: TLabel;
    Image2: TImage;
    Image3: TImage;
    Layout14: TLayout;
    Image4: TImage;
    Layout15: TLayout;
    Image5: TImage;
    Layout16: TLayout;
    Layout17: TLayout;
    lbl_login_tab: TLabel;
    lbl_login_conta: TLabel;
    Rectangle1: TRectangle;
    ActionList1: TActionList;
    ActConta: TChangeTabAction;
    ActEscolher: TChangeTabAction;
    ActFoto: TChangeTabAction;
    ActLogin: TChangeTabAction;
    Layout18: TLayout;
    Layout19: TLayout;
    Label5: TLabel;
    Label6: TLabel;
    Rectangle2: TRectangle;
    ActLibrary: TTakePhotoFromLibraryAction;
    ActCamera: TTakePhotoFromCameraAction;
    procedure lbl_login_contaClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure RoundRect6Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure RoundRect10Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure c_foto_editarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rect_loginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    permissao: T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.fmx}

uses UnitPincipal;

procedure TFormSplash.ActCameraDidFinishTaking(Image: TBitmap);
begin
  c_foto_editar.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TFormSplash.ActLibraryDidFinishTaking(Image: TBitmap);
begin
  c_foto_editar.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TFormSplash.c_foto_editarClick(Sender: TObject);
begin
 ActEscolher.Execute;
end;

procedure TFormSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FormSplash := nil;
end;

procedure TFormSplash.FormCreate(Sender: TObject);
begin
   permissao := T99Permissions.Create;
end;

procedure TFormSplash.FormDestroy(Sender: TObject);
begin
  permissao.DisposeOf;
end;

procedure TFormSplash.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
    FService : IFMXVirtualKeyboardService;
{$ENDIF}

begin
    {$IFDEF ANDROID}
    if (Key = vkHardwareBack) then
    begin
        TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
                                                          IInterface(FService));

        if (FService <> nil) and
           (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
        begin
            // Botao back pressionado e teclado visivel...
            // (apenas fecha o teclado)
        end
        else
        begin
            // Botao back pressionado e teclado NAO visivel...

            if TabControl1.ActiveTab = TabConta then
            begin
                Key := 0;
                ActLogin.Execute
            end
            else if TabControl1.ActiveTab = TabFoto then
            begin
                Key := 0;
                ActConta.Execute
            end
            else if TabControl1.ActiveTab = TabEscolher then
            begin
                Key := 0;
                ActFoto.Execute;
            end;
        end;
    end;
    {$ENDIF}
end;

procedure TFormSplash.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabLogin;
end;

procedure TFormSplash.TrataErroPermissao(Sender: TObject);
begin
  showmessage ('Você não possui permissão de acesso para este recurso');
end;

procedure TFormSplash.Image2Click(Sender: TObject);
begin
  permissao.Camera(ActCamera, TrataErroPermissao)
end;

procedure TFormSplash.Image3Click(Sender: TObject);
begin
  permissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
end;

procedure TFormSplash.Image4Click(Sender: TObject);
begin
  ActConta.Execute;
end;

procedure TFormSplash.Image5Click(Sender: TObject);
begin
 ActFoto.Execute;
end;

procedure TFormSplash.Label5Click(Sender: TObject);
begin
 ActLogin.Execute;
end;

procedure TFormSplash.lbl_login_contaClick(Sender: TObject);
begin
  ActConta.Execute;
end;

procedure TFormSplash.rect_loginClick(Sender: TObject);
begin
  if NOT Assigned(FormPrincipal) then
      Application.CreateForm(TFormPrincipal, FormPrincipal);

     Application.MainForm := FormPrincipal;
     FormPrincipal.Show;
     FormSplash.Close;
end;

procedure TFormSplash.RoundRect10Click(Sender: TObject);
begin
  ActEscolher.Execute;
end;

procedure TFormSplash.RoundRect6Click(Sender: TObject);
begin
  ActFoto.Execute;
end;

end.
