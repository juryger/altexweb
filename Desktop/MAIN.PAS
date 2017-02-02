unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, jpeg, EhLibBDE, AppSettingsHelper, FixBDE4GbBug;


type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ImageList1: TImageList;
    N1: TMenuItem;
    Window1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FileNew1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
    procedure CleanTempDir();
  public
    { Public declarations }
    IsLogoClosed, IsPriceClosed, IsNaklClosed, IsSkldClosed: boolean;
    Layout: array[0.. KL_NAMELENGTH] of char;    // Engl<->Rus
    procedure OpenPriceForm(Sender: TObject);
    procedure OpenNaklForm(Sender: TObject);
    procedure OpenSkladForm(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses ChildWin, About, Price, Logo, dbModule, Nakladnaya, Store;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
  if FileExists(Name) then Child.Memo1.Lines.LoadFromFile(Name);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('NONAME' + IntToStr(MDIChildCount + 1));
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
   if (not IsLogoClosed) then
   begin
      LogoForm.Left := MainForm.ClientWidth  - LogoForm.Width - 4;
      LogoForm.Top  := MainForm.ClientHeight - LogoForm.Height + 20;
   end;
   if (not IsPriceClosed) then
   begin
      PriceForm.Width  := MainForm.ClientWidth - 7;
      PriceForm.Height := MainForm.ClientHeight - 24;
      if ( (not IsNaklClosed) or ((not IsSkldClosed)) )then
      begin
         PriceForm.Left := 0;
         PriceForm.Top := 0;
         PriceForm.Width := 520;
      end;
   end;
   if (not IsNaklClosed) then
   begin
      NaklForm.Width  := MainForm.ClientWidth - 7;
      NaklForm.Height := MainForm.ClientHeight - 24;
      if (IsPriceClosed and (not IsSkldClosed)) then
      begin
         NaklForm.Left := 0;
         NaklForm.Top := 0;
         NaklForm.Width  := 520; //MainForm.Width - LogoForm.Width - 14;
      end;
      if (not IsPriceClosed) then
      begin
         NaklForm.Left := PriceForm.Width;
         NaklForm.Top := 0;
         NaklForm.Width := MainForm.ClientWidth - PriceForm.Width - 7;
      end;
   end;
   if (not IsSkldClosed) then
   begin
      StoreForm.Width  := MainForm.ClientWidth - 7;
      StoreForm.Height := MainForm.ClientHeight - 24;
      if (not IsNaklClosed) then
      begin
         StoreForm.Left := NaklForm.Width;
         StoreForm.Top := 0;
         StoreForm.Width := MainForm.ClientWidth - NaklForm.Width - 7;
      end;
      if (IsNaklClosed and (not IsPriceClosed)) then
      begin
         StoreForm.Left := PriceForm.Width;
         StoreForm.Top := 0;
         StoreForm.Width := MainForm.ClientWidth - PriceForm.Width - 7;
      end;
      {if (not IsNaklClosed) then begin
         StoreForm.Left := 0; StoreForm.Top := 0;
         StoreForm.Width  := MainForm.Width - LogoForm.Width - 14;
         StoreForm.Height := MainForm.Height - 77;
      end;
      if (not IsPriceClosed) then begin
         StoreForm.Left := 499; StoreForm.Top := 0; StoreForm.Width := 521; StoreForm.Height := 480;
      end;
      if (IsLogoClosed) then StoreForm.WindowState := wsMaximized}
   end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   IsLogoClosed  := true;
   IsPriceClosed := true;
   IsNaklClosed  := true;

   // Очистить содержимое временного каталога (Excel файлы)
   CleanTempDir();
end;

procedure TMainForm.N2Click(Sender: TObject);
var
  Child: TLogoForm;
begin
   if (IsLogoClosed) then begin
      IsLogoClosed := false;
      Child := TLogoForm.Create(Application);
      LogoForm := Child;
      LogoForm.FormStyle := fsStayOnTop;
      LogoForm.BorderStyle := bsNone;
      LogoForm.Show();
      FormResize(Sender);
   end
   else LogoForm.Show();
end;

procedure TMainForm.N6Click(Sender: TObject);
begin
   Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
	host: string;
begin
   LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
   IsLogoClosed  := true;
   IsPriceClosed := true;
   IsNaklClosed  := true;
   IsSkldClosed  := true;
   N2Click(sender);
end;

procedure TMainForm.OpenPriceForm(Sender: TObject);
var
   Child: TPriceForm;
begin
   if (IsPriceClosed) then begin
      IsPriceClosed := false;
      Child := TPriceForm.Create(Application);
      Child.Left := 0; Child.Top := 0;
      PriceForm := Child;
      FormResize(Sender);
   end
   else PriceForm.Show();
end;

procedure TMainForm.OpenNaklForm(Sender: TObject);
var
   Child: TNaklForm;
begin
   if (IsNaklClosed) then begin
      IsNaklClosed := false;
      Child := TNaklForm.Create(Application);
      Child.Left := 0; Child.Top := 0;
      NaklForm := Child;
      FormResize(Sender);
   end
   else NaklForm.Show();
end;

procedure TMainForm.OpenSkladForm(Sender: TObject);
var
   Child: TStoreForm;
begin
   if (IsSkldClosed) then begin
      IsSkldClosed := false;
      Child := TStoreForm.Create(Application);
      Child.Left := 0; Child.Top := 0;
      StoreForm := Child;
      FormResize(Sender);
   end
   else StoreForm.Show();
end;

procedure TMainForm.N7Click(Sender: TObject);
begin
   OpenPriceForm(Sender);
end;

procedure TMainForm.N10Click(Sender: TObject);
begin
   OpenNaklForm(Sender);
end;

procedure TMainForm.N9Click(Sender: TObject);
begin
   OpenSkladForm(Sender);
end;

procedure TMainForm.CleanTempDir();
var
  sr: TSearchRec;
  tempDir: string;
  excelDir: string;
  workDir: string;
begin
  // 1. Почистить каталог с эксель файлами
  tempDir := GetSettingsParam(Self, 'TempDir');
  if (tempDir = '') then
	  exit;

  excelDir := tempDir + '\AG\Excel';

  if FindFirst(excelDir + '\*.*', faAnyFile, sr) = 0 then
  repeat
    if ((sr.Name <> '.') AND (sr.Name <> '..')) then
        DeleteFile(excelDir + '\' + sr.Name);
  until FindNext(SR) <> 0;
  FindClose(sr);

  // 2. Почистить рабочий каталог приложения, файлы *.MB
  workDir := ExtractFilePath(ParamStr(0));
  if FindFirst(workDir+'\*.mb', faAnyFile, sr) = 0 then
  repeat
    DeleteFile(workDir + '\' + sr.Name);
  until FindNext(SR) <> 0;
  FindClose(sr);
end;

end.
