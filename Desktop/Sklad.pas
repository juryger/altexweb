unit Sklad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, Buttons, Db;

type
  TSkladForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    DBEditEh1: TDBEditEh;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    DBGridEh1: TDBGridEh;
    Panel5: TPanel;
    Label3: TLabel;
    DBComboBoxEh1: TDBComboBoxEh;
    DBGridEh2: TDBGridEh;
    Panel6: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel7: TPanel;
    SpeedButton4: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBEditEh1Change(Sender: TObject);
    procedure DBEditEh1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGridEh2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGridEh2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGridEh2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridEh1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGridEh1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    priceDragObj: boolean;
    procedure RefreshMainTable();
  end;

var
  SkladForm: TSkladForm;

implementation

uses dbModule, MAIN, Price;

{$R *.DFM}

procedure TSkladForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   MainForm.IsSkldClosed := true;
   MainForm.StatusBar1.Panels[0].Text := '';
   priceDragObj := false;
end;

procedure TSkladForm.FormShow(Sender: TObject);
begin
   //DBComboBoxEh1.ItemIndex := 0;
   //RefreshMainTable();
   //DBGridEh1.SetFocus;
end;

procedure TSkladForm.RefreshMainTable();
var
   fs: String;
begin
   if DBmod.TSKD_GRP.RecordCount=0 then begin
      DBmod.TSKD_DTL.Filtered := false;
      DBmod.TSKD_DTL.Filter := 'ID_SKL_GRP=-1';
      DBmod.TSKD_DTL.Filtered := true;
      exit;
   end;
   fs := DBmod.TSKD_GRP.FieldByName('ID_SKL_GRP').AsString; if fs='' then fs := '-1';
   DBmod.TSKD_DTL.Filtered := false;
   if (not DBmod.TGDS_GRP.Locate('DESCRIPTION',DBComboBoxEh1.Text,[loPartialKey,loCaseInsensitive])) then
      DBmod.TSKD_DTL.Filter := 'ID_SKL_GRP='+fs
   else
      DBmod.TSKD_DTL.Filter := 'ID_SKL_GRP='+fs+' and ID_GDS_GRP='+DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsString;
   DBmod.TSKD_DTL.Filtered := true;
   MainForm.StatusBar1.Panels[0].Text := 'Всего записей: '+ IntToStr(DBmod.TSKD_DTL.RecordCount);
   Label5.Caption := DBmod.TSKD_GRP.FieldByName('SDATE').AsString;
end;

procedure TSkladForm.DBGridEh2CellClick(Column: TColumnEh);
begin
   RefreshMainTable();
end;

procedure TSkladForm.DBEditEh1Change(Sender: TObject);
begin
   If DBEditEh1.Text='' then DBmod.TGDS_DTL.First
   else DBmod.TSKD_DTL.Locate('GDS_DESCR',DBEditEh1.Text,[loPartialKey,loCaseInsensitive])
end;

procedure TSkladForm.DBEditEh1Click(Sender: TObject);
begin
   DBEditEh1.SelectAll;
end;

procedure TSkladForm.SpeedButton2Click(Sender: TObject);
begin
   if (DBmod.TSKD_DTL.RecordCount=0) then exit;
   if MessageDlg('Хотите удалить позицию <'+ DBmod.TSKD_DTL.FieldByName('GDS_DESCR').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
   DBmod.TSKD_DTL.Delete;
end;

procedure TSkladForm.SpeedButton1Click(Sender: TObject);
var
   i: integer;
begin
   if (DBmod.TSKD_GRP.RecordCount=0) then exit;
   if MessageDlg('Хотите удалить склад <'+ DBmod.TSKD_GRP.FieldByName('DESCRIPRION').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
   if (DBmod.TSKD_DTL.RecordCount<>0) then
      for i:=1 to DBmod.TSKD_DTL.RecordCount do DBmod.TSKD_DTL.Delete;
   DBmod.TSKD_GRP.Delete;
   RefreshMainTable();
end;

procedure TSkladForm.DBGridEh2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   if ((DBmod.TSKD_GRP.RecordCount<>0)and(PriceForm.priceDragObj)) then Accept := true
   else Accept := false;
end;

procedure TSkladForm.DBGridEh2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
   desc: String;
   grp_i,dtl_i: Integer;
begin
  if DBMod.TSKD_GRP.RecordCount = 0 then exit;
  if (Sender is TDBGridEh) and (PriceForm.priceDragObj) then
  begin
    with Sender as TDBGridEh do
    begin
      dtl_i := DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value;
      grp_i := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').Value;
      desc      := DBmod.TGDS_DTL.FieldByName('DESCRIPTION').AsString;
      // Добавить запись loPartialKey,loCaseInsensitive
      if DBmod.TSKD_DTL.Locate('ID_GDS_DTL',dtl_i,[]) then DBmod.TSKD_DTL.Edit()
      else DBmod.TSKD_DTL.Insert();
      DBmod.TSKD_DTL.FieldByName('ID_SKL_GRP').Value   := DBmod.TSKD_GRP.FieldByName('ID_SKL_GRP').Value;
      DBmod.TSKD_DTL.FieldByName('ID_GDS_DTL').Value   := dtl_i;
      DBmod.TSKD_DTL.FieldByName('ID_GDS_GRP').Value   := grp_i;
      DBmod.TSKD_DTL.FieldByName('GDS_DESCR').AsString := desc;
      DBmod.TSKD_DTL.FieldByName('NUMBER').Value     := 0;
      DBmod.TSKD_DTL.Post;
    end;
  end;
end;

procedure TSkladForm.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbRight then begin
      priceDragObj := true;
      DBGridEh1.BeginDrag(True);
   end
   else priceDragObj := false;
end;

procedure TSkladForm.SpeedButton3Click(Sender: TObject);
begin
   DBmod.QSklad.Close();
   DBmod.QSklad.Open();
   DBmod.frReport1.Dataset := DBmod.frSklad;
   DBmod.frReport1.LoadFromFile('Sklad.frf');
   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.PrintPreparedReportDlg;
end;

procedure TSkladForm.DBGridEh1TitleClick(Column: TColumnEh);
begin
   ShowMessage('X='+IntToStr(SkladForm.Left)+' Y'+IntToStr(SkladForm.Top)+' W'+IntToStr(SkladForm.Width)+' H'+IntToStr(SkladForm.Height));
end;

procedure TSkladForm.DBGridEh2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RefreshMainTable();
end;

procedure TSkladForm.DBGridEh2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   RefreshMainTable();
end;

procedure TSkladForm.FormCreate(Sender: TObject);
begin
   {DBComboBoxEh1.Items.Clear;
   DBComboBoxEh1.Items.Add('Все товары');
   DBmod.TGDS_GRP.First;
   for i:=1 to DBmod.TGDS_GRP.RecordCount do begin
      DBComboBoxEh1.Items.Add(DBmod.TGDS_GRP.FieldByName('Description').AsString);
      DBmod.TGDS_GRP.Next;
   end;
   DBmod.TGDS_GRP.First;}
end;

procedure TSkladForm.DBGridEh1CellClick(Column: TColumnEh);
begin
   RefreshMainTable();
end;

procedure TSkladForm.DBGridEh1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RefreshMainTable();
end;

procedure TSkladForm.DBGridEh1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   RefreshMainTable();
end;

procedure TSkladForm.DBGridEh1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   if (Source=DBGridEh2) then Accept := true
   else Accept := false;
end;

procedure TSkladForm.DBGridEh1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
   gc: TGridCoord;
   old_recno: Integer;
begin
  if (Sender is TDBGridEh) and (Source=DBGridEh2) then
  begin
    with Sender as TDBGridEh do
    begin
      // Получить строку в таблице под мышкой
      gc := DBGridEh1.MouseCoord(X,Y);
      old_recno := DBmod.TSKD_GRP.RecNo;
      if (old_recno=gc.Y) then exit;
      DBmod.TSKD_GRP.RecNo := gc.Y;
      DBmod.TSKD_DTL.Edit();
      DBmod.TSKD_DTL.FieldByName('ID_SKL_GRP').Value  := DBmod.TSKD_GRP.FieldByName('ID_SKL_GRP').Value;
      DBmod.TSKD_DTL.Post;
      // Вернутся на старую запись
      DBmod.TSKD_GRP.RecNo := old_recno;
    end;
  end;
end;

procedure TSkladForm.SpeedButton4Click(Sender: TObject);
var i,j,idgg: integer;
begin
   if (DbMod.TSKD_GRP.RecordCount = 0) then begin
      ShowMessage('Сначало добавьте хотя бы один склад.');
      exit;
   end;
   DbMod.TGDS_GRP.Filtered := false;
   DbMod.TGDS_GRP.First;
   DbMod.TSKD_DTL.First;
   for i:=1 to DbMod.TGDS_GRP.RecordCount do begin
      DbMod.TGDS_DTL.Filtered := false;
      DbMod.TGDS_DTL.Filter := 'ID_GDS_GRP='+DbMod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsString+' and DEL<>1';
      DbMod.TGDS_DTL.Filtered := true;
      idgg := DbMod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsInteger;
      for j:=1 to DbMod.TGDS_DTL.RecordCount do begin
         if (not DbMod.TSKD_DTL.Locate('ID_GDS_DTL',DbMod.TGDS_DTL.FieldByName('ID_GDS_DTL').AsInteger,[])) then begin
            DbMod.TSKD_DTL.Insert();
            DbMod.TSKD_DTL.FieldByName('ID_SKL_GRP').AsInteger := DbMod.TSKD_GRP.FieldByName('ID_SKL_GRP').AsInteger;
            DbMod.TSKD_DTL.FieldByName('ID_GDS_GRP').AsInteger := idgg;
            DbMod.TSKD_DTL.FieldByName('ID_GDS_DTL').AsInteger := DbMod.TGDS_DTL.FieldByName('ID_GDS_DTL').AsInteger;
            DbMod.TSKD_DTL.FieldByName('GDS_DESCR').AsString := DBmod.TGDS_DTL.FieldByName('DESCRIPTION').AsString;
            DbMod.TSKD_DTL.FieldByName('NUMBER').AsInteger := 0;
            DbMod.TSKD_DTL.Post();
         end;
         DbMod.TGDS_DTL.Next;
      end;
      DbMod.TGDS_GRP.Next;
   end;
   DBComboBoxEh1.ItemIndex := 0;
   RefreshMainTable();
end;

procedure TSkladForm.DBComboBoxEh1Change(Sender: TObject);
begin
   RefreshMainTable();
end;

end.
