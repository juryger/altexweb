unit Store;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, Buttons, dbModule, StdCtrls, Mask,
  DBCtrlsEh, Db;

type
  TStoreForm = class(TForm)
    leftPanel: TPanel;
    subgroupGrid: TDBGridEh;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    groupGrid: TDBGridEh;
    rightPanel: TPanel;
    controlPanel: TPanel;
    goodsGrid: TDBGridEh;
    SpeedButton1: TSpeedButton;
    DBEditEh2: TDBEditEh;
    Label2: TLabel;
    Label3: TLabel;
    DBEditEh1: TDBEditEh;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure groupGridCellClick(Column: TColumnEh);
    procedure subgroupGridCellClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure DBEditEh2Click(Sender: TObject);
    procedure DBEditEh2Change(Sender: TObject);
    procedure DBEditEh1Change(Sender: TObject);
    procedure DBEditEh1Click(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshSubgroupsTable();
    procedure RefreshGoodsDetailsTable();
  public
    { Public declarations }
  end;

var
  StoreForm: TStoreForm;

implementation

uses MAIN;

{$R *.dfm}

procedure TStoreForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   MainForm.IsSkldClosed := true;
   MainForm.StatusBar1.Panels[0].Text := '';
end;

procedure TStoreForm.groupGridCellClick(Column: TColumnEh);
begin
	RefreshSubgroupsTable();
end;

procedure TStoreForm.subgroupGridCellClick(Column: TColumnEh);
begin
	RefreshGoodsDetailsTable();
end;

procedure TStoreForm.FormShow(Sender: TObject);
begin
   RefreshSubgroupsTable();
   groupGrid.SetFocus;
end;

procedure TStoreForm.RefreshSubgroupsTable();
var
   fs: String;
begin
   if DBmod.TGDS_GRP.RecordCount=0 then
   begin
      DBmod.TGDS_SGRP.Filtered := false;
      DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=-1 and DEL<>1';
      DBmod.TGDS_SGRP.Filtered := true;

      RefreshGoodsDetailsTable();
      exit;
   end;

   // представление "Все записи"
   if DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString = '*' then
   begin
      DBmod.TGDS_SGRP.Filtered := false;
      DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=-1 and DEL<>1';
      DBmod.TGDS_SGRP.Filtered := true;

      // показать все записи таблицы склада
	   DBmod.QSTR.Close();
	   DBmod.QSTR.ParamByName('LOW').Value := 0;
	   DBmod.QSTR.ParamByName('HIGH').Value := 1000000;
	   DBmod.QSTR.Open();
      exit;
   end;

   fs := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsString;
   if fs='' then fs := '-1';

   DBmod.TGDS_SGRP.Filtered := false;
   DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP='+fs +' and DEL<>1';
   DBmod.TGDS_SGRP.Filtered := true;

   RefreshGoodsDetailsTable();
end;

procedure TStoreForm.RefreshGoodsDetailsTable();
begin
   if DBmod.TGDS_SGRP.RecordCount = 0 then begin
   	DBmod.QSTR.Close();
      DBmod.QSTR.ParamByName('LOW').Value := -1;
      DBmod.QSTR.ParamByName('HIGH').Value := -1;
      DBmod.QSTR.Open();
      exit;
   end;

   DBmod.QSTR.Close();
   DBmod.QSTR.ParamByName('LOW').Value := DBmod.TGDS_SGRP.FieldByName('ID_GDS_SGRP').Value;
   DBmod.QSTR.ParamByName('HIGH').Value := DBmod.TGDS_SGRP.FieldByName('ID_GDS_SGRP').Value;
   DBmod.QSTR.Open();
end;


procedure TStoreForm.DBEditEh2Click(Sender: TObject);
begin
   DBEditEh2.SelectAll;
end;

procedure TStoreForm.DBEditEh2Change(Sender: TObject);
begin
   If DBEditEh2.Text='' then
   	DBmod.QSTR.First
   else
   	DBmod.QSTR.Locate('ID_GDS_DTL',DBEditEh2.Text,[loPartialKey,loCaseInsensitive]);
end;

procedure TStoreForm.DBEditEh1Change(Sender: TObject);
begin
   If DBEditEh1.Text='' then
   	DBmod.QSTR.First
   else
   	DBmod.QSTR.Locate('DESCRIPTION',DBEditEh1.Text,[loPartialKey,loCaseInsensitive])
end;

procedure TStoreForm.DBEditEh1Click(Sender: TObject);
begin
   DBEditEh1.SelectAll;
end;

end.
