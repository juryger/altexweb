unit Price;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, Buttons, Db,
  DBLookupEh, Menus, ExtDlgs, DBTables, dbModule, MAIN, ImagePrepare, StoreView, XLSWorkbook,
  Variants, AppSettingsHelper, XMLDoc, XMLIntf, jpeg;
  // msxml, xmldom, XMLIntf, XMLDoc;
type
  TPriceForm = class(TForm)
    goodsCategoriesPanel: TPanel;
    picturePopupMenu: TPopupMenu;
    popupItemSetPicture: TMenuItem;
    popupItemClearPicture: TMenuItem;
    openGoodPictureDialog: TOpenPictureDialog;
    popupItemViewPicture: TMenuItem;
    subGroupsPopupMenu: TPopupMenu;
    popupItemStore: TMenuItem;
    N1: TMenuItem;
    groupsMainPanel: TPanel;
    subgroupsMainPanel: TPanel;
    sgControlsPanel: TPanel;
    addSubgroupButton: TSpeedButton;
    deleteSubgroupButton: TSpeedButton;
    DBGridEh3: TDBGridEh;
    gControlsPanel: TPanel;
    addGroupButton: TSpeedButton;
    deleteGroupButton: TSpeedButton;
    DBGridEh2: TDBGridEh;
    Splitter2: TSplitter;
    goodsMainPanel: TPanel;
    DBGridEh1: TDBGridEh;
    goodsControlsPanel: TPanel;
    addGoodsButton: TSpeedButton;
    deleteGoodsButton: TSpeedButton;
    deleteBadBlob: TSpeedButton;
    searchPanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    Splitter1: TSplitter;
    discountsButton: TSpeedButton;
    Panel1: TPanel;
    uploadWebButton: TSpeedButton;
    printButton: TSpeedButton;
    previewButton: TSpeedButton;
    exportButton: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBEditEh1Change(Sender: TObject);
    procedure DBEditEh1Click(Sender: TObject);
    procedure deleteGoodsButtonClick(Sender: TObject);
    procedure deleteGroupButtonClick(Sender: TObject);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure printButtonClick(Sender: TObject);
    procedure DBGridEh2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure picturePopupMenuPopup(Sender: TObject);
    procedure popupItemSetPictureClick(Sender: TObject);
    procedure popupItemClearPictureClick(Sender: TObject);
    procedure previewButtonClick(Sender: TObject);
    procedure popupItemViewPictureClick(Sender: TObject);
    procedure DBGridEh1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEditEh2Click(Sender: TObject);
    procedure DBEditEh2Change(Sender: TObject);
    procedure exportButtonClick(Sender: TObject);
    procedure DBGridEh3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGridEh3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGridEh3CellClick(Column: TColumnEh);
    procedure DBGridEh3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure subGroupsMenuItemClick(Sender: TObject);
    procedure deleteSubgroupButtonClick(Sender: TObject);
    procedure deleteBadBlobClick(Sender: TObject);
    procedure uploadWebButtonClick(Sender: TObject);
    procedure popupItemStoreClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1SortMarkingChanged(Sender: TObject);
    procedure addGroupButtonClick(Sender: TObject);
    procedure addSubgroupButtonClick(Sender: TObject);
    procedure addGoodsButtonClick(Sender: TObject);
    procedure discountsButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure SaveImageInternal(bitMap: TBitmap);
    procedure PrepareExcelHeader(sheet: TSheet);
    procedure PrepareCatalogSheet(sheet: TSheet);
    procedure AddLinksToImagesOnPriceSheet(sheet: TSheet);
    procedure CleanTempDir();
    procedure MakeTGDSColumsReadOnly(flag: boolean);
    procedure ShowStoreView();
    procedure SaveStoreInternal(gds_id: Integer; income: Integer; outcome: Integer);
    procedure RefreshSubgroupsTable();
    procedure RefreshGoodsDetailsTable();
    procedure ExportImageToFile(fileName: string; blobStream: TBlobStream);
    function ShellExecAndWait(ExeFile: string; Parameters: string = ''; ShowWindow: Word = SW_SHOWNORMAL): DWord;
    function SplitString(const Original: String; Splitter: Char): TStringList;
    procedure SerializeDiscountsUpdate(updatesRoot: IXMLNode);
  public
    { Public declarations }
    priceDragObj: boolean;
  end;

var
    PriceForm: TPriceForm;
    imgIndexes: TStringList;
    subGroupsMain: String;
    showDeletedRecords: boolean;
    
implementation

uses BeforePricePrint, fullImageView, ShellAPI, XLSFormat, FILECTRL
   { ---------------------------------------------------------------------------
   Use required TXLSFile library units
   --------------------------------------------------------------------------- }
   , XLSFile
   , XLSHyperlink, Math, Discounts;

{$R *.DFM}
const FOF_NO_UI = 1556;

procedure TPriceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   MainForm.IsPriceClosed := true;
   MainForm.StatusBar1.Panels[0].Text := '';
   priceDragObj := false;
end;

procedure TPriceForm.FormShow(Sender: TObject);
begin
   RefreshSubgroupsTable();
   DBGridEh2.SetFocus;
end;

procedure TPriceForm.RefreshSubgroupsTable();
var
   fs: String;
   deletedRecordsFilter, deletedRecordsFilter2: String;
begin
	deletedRecordsFilter := '';
	deletedRecordsFilter := '';
	if showDeletedRecords = false then
   begin
   	deletedRecordsFilter := ' AND DEL<>1';
      deletedRecordsFilter2 := 'DEL<>1';
   end;

   if DBmod.TGDS_GRP.RecordCount=0 then
   begin
      DBmod.TGDS_SGRP.Filtered := false;
      DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=-1' + deletedRecordsFilter;
      DBmod.TGDS_SGRP.Filtered := true;

      RefreshGoodsDetailsTable();
      exit;
   end;

   // представление "Все записи"
   if DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString = '*' then
   begin
      DBmod.TGDS_SGRP.Filtered := false;
      DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=-1' + deletedRecordsFilter;
      DBmod.TGDS_SGRP.Filtered := true;

      RefreshGoodsDetailsTable();

      DBmod.TGDS_DTL.Filtered := false;
      DBmod.TGDS_DTL.Filter := deletedRecordsFilter2;
      DBmod.TGDS_DTL.Filtered := true;

      MakeTGDSColumsReadOnly(true);

      MainForm.StatusBar1.Panels[0].Text := 'Всего записей: '+ IntToStr(DBmod.TGDS_DTL.RecordCount);
      MainForm.StatusBar1.Panels[1].Text := 'Данное предстваление только для Просмотра. Для редактирования выберите группу отличную от "*".';
      exit;
   end;

   fs := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsString;
   if fs='' then fs := '-1';

   DBmod.TGDS_SGRP.Filtered := false;
   DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=' + fs + deletedRecordsFilter;
   DBmod.TGDS_SGRP.Filtered := true;

   // добавление подгруппы с именем '(прочее)' - общая подкатигория
   if DBmod.TGDS_SGRP.RecordCount = 0 then begin
        DBmod.TGDS_SGRP.Insert();
        DBmod.TGDS_SGRP.FieldByName('ID_GDS_GRP').Value := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').Value;
        DBmod.TGDS_SGRP.FieldByName('DESCRIPTION').Value := subGroupsMain;
        DBmod.TGDS_SGRP.FieldByName('DEL').Value := '0';
        DBmod.TGDS_SGRP.Post();
   end;

   RefreshGoodsDetailsTable();
end;

procedure TPriceForm.RefreshGoodsDetailsTable();
var
   fs: String;
   deletedRecordsFilter: String;
begin
	deletedRecordsFilter := '';
	if showDeletedRecords = false then
   	deletedRecordsFilter := ' AND DEL<>1';

   if DBmod.TGDS_SGRP.RecordCount=0 then
   begin
      DBmod.TGDS_DTL.Filtered := false;
      DBmod.TGDS_DTL.Filter := 'ID_GDS_SGRP=-1' + deletedRecordsFilter;
      DBmod.TGDS_DTL.Filtered := true;

      MakeTGDSColumsReadOnly(true);
      exit;
   end;

   MakeTGDSColumsReadOnly(false);

   fs := DBmod.TGDS_SGRP.FieldByName('ID_GDS_SGRP').AsString;
   if fs='' then fs := '-1';

   DBmod.TGDS_DTL.Filtered := false;
   DBmod.TGDS_DTL.Filter := 'ID_GDS_SGRP=' + fs + deletedRecordsFilter;
   DBmod.TGDS_DTL.Filtered := true;

   MainForm.StatusBar1.Panels[0].Text := 'Всего записей: '+ IntToStr(DBmod.TGDS_DTL.RecordCount);
   MainForm.StatusBar1.Panels[1].Text := 'Горячие клавиши таблицы Товары: F3 - задать/просмотреть изображение, F8 - удалить изображение; F10 - приход/остаток.';
end;

procedure TPriceForm.DBGridEh2CellClick(Column: TColumnEh);
begin
   RefreshSubgroupsTable();
end;

procedure TPriceForm.DBEditEh1Change(Sender: TObject);
begin
   If DBEditEh1.Text='' then DBmod.TGDS_DTL.First
   else DBmod.TGDS_DTL.Locate('DESCRIPTION',DBEditEh1.Text,[loPartialKey,loCaseInsensitive])
end;

procedure TPriceForm.DBEditEh1Click(Sender: TObject);
begin
   DBEditEh1.SelectAll;
end;

procedure TPriceForm.deleteGoodsButtonClick(Sender: TObject);
begin
   { WARNING:>
     Обязательно сделать проверку на использование ссылки на товар в табл.:
     Накладные, Склад, Учет.
   }
   if (DBmod.TGDS_DTL.RecordCount=0) then
        exit;

   if MessageDlg('Хотите удалить позицию <'+ DBmod.TGDS_DTL.FieldByName('DESCRIPTION').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

   // !!! В целях синхронизации с сайтом группа, подгруппа и товар всегда только помечаются как удаленные

   // добавил проверку на то, что товар уже выгружен на веб-сайт (следовательно удаление должно отработать и на веб-саате)
   //if ((DBmod.TSLS_DTL.Locate('ID_GDS_DTL', DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value, []))or
   //    (DBmod.TSTR.Locate('ID_GDS_DTL', DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value, [])) or
   //    (DBmod.TGDS_DTL.FieldByName('UPLOADED').AsInteger = 1)) then
   //begin
      {удаление изображения }
      popupItemClearPictureClick(Self);

      DBmod.TGDS_DTL.Edit;
      DBmod.TGDS_DTL.FieldByName('DEL').Value := 1;
      DBmod.TGDS_DTL.Post;
   //end
   //else
   //     DBmod.TGDS_DTL.Delete;

   DBmod.TGDS_DTL.FlushBuffers;
end;

procedure TPriceForm.deleteGroupButtonClick(Sender: TObject);
var
   i, j: integer;
//   isGroupDel, isSubGroupDel: boolean;
begin
   { WARNING:>
     Обязательно сделать проверку на использование ссылки на товар в табл.:
     Накладные, Склад, Учет.
   }
   if (DBmod.TGDS_GRP.RecordCount=0)
    then exit;
   if (DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString = '*')
    then exit;

   if MessageDlg('Хотите удалить вид товаров <'+ DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

   //isGroupDel := false;

   // Поиск товаров данной группы и всех подгрупп в "Накладных" и на "Складе"
   DBmod.TGDS_SGRP.First;
   for i:=1 to DBmod.TGDS_SGRP.RecordCount do
   begin
   	RefreshGoodsDetailsTable();

   	//isSubGroupDel := false;
      for j:=1 to DBmod.TGDS_DTL.RecordCount do begin

         // !!! В целях синхронизации с сайтом группа, подгруппа и товар всегда только помечаются как удаленные

      	//if ((DBmod.TSLS_DTL.Locate('ID_GDS_DTL',DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value,[])) or
         //	(DBmod.TSTR.Locate('ID_GDS_DTL',DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value,[])) or
         //   (DBmod.TGDS_DTL.FieldByName('UPLOADED').AsInteger = 1)) then
         //begin
            	// хотя запись и помечается как удаленная, необходимо очистить поле IMAGE (т.к. занимает много места в БД)
            	popupItemClearPictureClick(Self);

            	DBmod.TGDS_DTL.Edit;
            	DBmod.TGDS_DTL.FieldByName('DEL').Value := 1;
            	DBmod.TGDS_DTL.Post;
            	//isSubGroupDel := true;
               //isGroupDel := true;
         //end
         //else
         //	DBmod.TGDS_DTL.Delete; // товар не найден
      end;

   	//if (isSubGroupDel = true) then
   	//begin
      	// отмечаем подгруппу как удаленную
         DBmod.TGDS_SGRP.Edit;
         DBmod.TGDS_SGRP.FieldByName('DEL').Value := 1;
         DBmod.TGDS_SGRP.Post;
      //end
      //else
      //	DBmod.TGDS_SGRP.Next;
   end;

   // !!! В целях синхронизации с сайтом группа, подгруппа и товар всегда только помечаются как удаленные
   
   // Если товары из текущей группы имеются на складе или в накладных,
   // то запись в тбалице Группы помечается как удаленная. Иначе удаление записи.
   //if (isGroupDel = true) then
   //begin
   	// отмечаем группу как удаленную
      DBmod.TGDS_GRP.Edit;
      DBmod.TGDS_GRP.FieldByName('DEL').Value := 1;
      DBmod.TGDS_GRP.Post;
   //end
   //else
   //begin
   	// удаляем все подгруппы
   	//for i:=1 to DBmod.TGDS_SGRP.RecordCount do
      //	DBmod.TGDS_SGRP.Delete;

      // удаляем группу
      //DBmod.TGDS_GRP.Delete;
   //end;

   DBmod.TGDS_DTL.FlushBuffers;

   RefreshSubgroupsTable();
end;

procedure TPriceForm.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbLeft then begin
      priceDragObj := true;
      DBGridEh1.BeginDrag(True);
   end
   else priceDragObj := false;
end;

procedure TPriceForm.printButtonClick(Sender: TObject);
begin
   // Печать прайса с фотографиями
   DBmod.QPrice.Close();
   DBmod.QPrice.Open();
   DBmod.frReport1.Dataset := DBmod.frPrice;
   DBmod.frReport1.LoadFromFile('ColorPrice.frf');
   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.PrintPreparedReportDlg;
end;

procedure TPriceForm.DBGridEh2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RefreshSubgroupsTable();
end;

procedure TPriceForm.picturePopupMenuPopup(Sender: TObject);
begin
    if DBmod.TGDS_DTLIMAGE.BlobSize > 0 then
    begin
      popupItemClearPicture.Enabled := true;
      popupItemViewPicture.Enabled := true;
    end
    else begin
      popupItemViewPicture.Enabled := false;
      popupItemClearPicture.Enabled := false;
    end;
end;

procedure TPriceForm.popupItemSetPictureClick(Sender: TObject);
var
   ImageEditorForm: TImageEditorForm;
begin
   if openGoodPictureDialog.Execute() = false then
      exit;

   ImageEditorForm := TImageEditorForm.Create(Application);
   ImageEditorForm.imgFileName := openGoodPictureDialog.FileName;

   if ImageEditorForm.ShowModal <> mrOK then
   begin
      ImageEditorForm.Dispose();
      exit;
   end;

   SaveImageInternal(ImageEditorForm.imageDst.Picture.Bitmap);
   ImageEditorForm.Dispose();
end;

//------------------------------------------------------------------------------
// Save Image (from bitmap) to Database.
//------------------------------------------------------------------------------
procedure TPriceForm.SaveImageInternal(bitMap: TBitmap);
var
   blobStream: TBlobStream;
begin
   if (bitMap = nil) then
      raise Exception.Create('SaveImageInternal, bitMap not defined.');

   try
      try
         DBmod.TGDS_DTL.Edit;

         blobStream :=
            DBmod.TGDS_DTL.CreateBlobStream(
                DBmod.TGDS_DTL.FieldByName('IMAGE'), bmWrite) as TBlobStream;

         blobStream.Seek(0, soFromBeginning);
         bitMap.SaveToStream(blobStream);

         DBmod.TGDS_DTLIMAGE_SET.Value := 1;
      except
        on E: Exception do
            ShowMessage('При сохранении изображения в БД возникла ошибка = ' +
                E.Message + ' Обратитесь к разработчику.');
      end;
   finally
        if blobStream <> nil then
            blobStream.Free;

        DBmod.TGDS_DTL.Post;
   end;
end;

procedure TPriceForm.popupItemClearPictureClick(Sender: TObject);
var
   blobStream: TBlobStream;
begin
    If (DBmod.TGDS_DTLIMAGE.BlobSize > 0) then
    begin
      DBmod.TGDS_DTL.Edit;
      blobStream :=
         DBmod.TGDS_DTL.CreateBlobStream(
            DBmod.TGDS_DTL.FieldByName('IMAGE'), bmWrite) as TBlobStream;
      blobStream.Seek(0, soFromBeginning);
      blobStream.Truncate;
      blobStream.Free;
      DBmod.TGDS_DTL.Post;
    end;
end;

procedure TPriceForm.previewButtonClick(Sender: TObject);
begin
   // Просмотр прайса с фотографиями
   DBmod.QPrice.Close();
   DBmod.QPrice.Open();
   DBmod.frReport1.Dataset := DBmod.frPrice;
   DBmod.frReport1.LoadFromFile('ColorPrice.frf');
   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.ShowReport;
end;

procedure TPriceForm.popupItemViewPictureClick(Sender: TObject);
var
   blobStream: TBlobStream;
   ImageEditorForm: TImageEditorForm;
begin
   ImageEditorForm := TImageEditorForm.Create(Application);

   blobStream :=
        DBmod.TGDS_DTL.CreateBlobStream(
            DBmod.TGDS_DTL.FieldByName('IMAGE'), bmRead) as TBlobStream;
   try
      blobStream.Seek(0, soFromBeginning);

      ImageEditorForm.imgImage := TImage.Create(ImageEditorForm);
      ImageEditorForm.imgImage.Picture.Bitmap.LoadFromStream(blobStream);
   finally
        if blobStream <> nil then
            blobStream.Free;
   end;

   if ImageEditorForm.ShowModal <> mrOK then
      exit;

   SaveImageInternal(ImageEditorForm.imageDst.Picture.Bitmap);
end;

procedure TPriceForm.ShowStoreView();
var
   StoreViewForm: TStoreViewForm;
   gds_id: Integer;
begin
   if (DBmod.TGDS_DTL.RecordCount = 0) then
      exit;

   gds_id := DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value;

   StoreViewForm := TStoreViewForm.Create(Application);

   if (DBmod.TSTR.Locate('ID_GDS_DTL', gds_id,[])) then
      StoreViewForm.num := DBmod.TSTR.FieldByName('NUM').Value
   else
     StoreViewForm.num := 0;

   StoreViewForm.Caption := 'Склад: ' + DBmod.TGDS_DTL.FieldByName('DESCRIPTION').Value;

   if StoreViewForm.ShowModal <> mrOK then
      exit;

   SaveStoreInternal(gds_id, StoreViewForm.income, StoreViewForm.outcome);
end;

procedure TPriceForm.SaveStoreInternal(gds_id: Integer; income: Integer; outcome: Integer);
var
  num: Integer;
begin
  if (DBmod.TSTR.Locate('ID_GDS_DTL', gds_id,[])) then
  begin
    num := DBmod.TSTR.FieldByName('NUM').Value + income - outcome;
    if (num <= 0) then
      	DBmod.TSTR.Delete
    else
    begin
      DBmod.TSTR.Edit;
      DBmod.TSTR.FieldByName('NUM').Value := num;
      DBmod.TSTR.Post;
    end;
  end
  else begin
    num := income - outcome;
    if (num > 0) then
    begin
	  DBmod.TSTR.Insert;
	  DBmod.TSTR.FieldByName('ID_GDS_DTL').Value := gds_id;
	  DBmod.TSTR.FieldByName('NUM').Value := income - outcome;
	  DBmod.TSTR.Post;
    end;
  end;

  DBmod.TSTR.FlushBuffers;
end;

procedure TPriceForm.DBGridEh1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // F3 pressed (просмотр изображения/задание нового)
    If (Key = 114) then
    begin
        If (DBmod.TGDS_DTLIMAGE.BlobSize > 0) then
            popupItemViewPictureClick(Self)
        else
            popupItemSetPictureClick(Self);
        exit;
    end;

    // F8 pressed (удаление изображения)
    If (Key = 119) And (DBmod.TGDS_DTLIMAGE.BlobSize > 0) then
    begin
        if MessageDlg('Подтверждаете удаление изображения?',
            mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
            popupItemClearPictureClick(Self);

            DBmod.TGDS_DTL.FlushBuffers;
        end;
        exit;
    end;

    // F10 (приход/остаток)
    If (Key = 121) then
      ShowStoreView();

end;

procedure TPriceForm.DBEditEh2Click(Sender: TObject);
begin
   DBEditEh2.SelectAll;
end;

procedure TPriceForm.DBEditEh2Change(Sender: TObject);
begin
   If DBEditEh2.Text='' then DBmod.TGDS_DTL.First
   else DBmod.TGDS_DTL.Locate('ID_GDS_DTL',DBEditEh2.Text,[loPartialKey,loCaseInsensitive])
end;

function GetParentDirectory(path : string) : string;
begin
   result := ExpandFileName(path + '\..')
end;

procedure TPriceForm.exportButtonClick(Sender: TObject);
var fileName, tempDir, excelDir: string;
begin
    DbMod.ExportPriceExcelFile.Workbook.Clear;

    // Добавляем новый лист для таблицы цен
    DbMod.ExportPriceExcelFile.Workbook.Sheets.Add('Прайс');

    // Заголовок отчета каталог цен.
    PrepareExcelHeader(DbMod.ExportPriceExcelFile.Workbook.Sheets[0]);

    // содержимое отчета каталог цен.
    DBmod.QPriceExcel.Close();
    DBmod.QPriceExcel.Open();
    DbMod.XLSExportPriceDataSource.ExportData(0, 5, 0);

	// определить путь к каталогу Temp из файла настроек
   tempDir := GetSettingsParam(Self, 'TempDir');
  	if (tempDir = '') then
   begin
   	MessageDlg('В файле настроек AppSettings.xml не задан параметр TempDir.',
      	mtError, [mbOK], 0);
   	exit;
   end;

    excelDir := tempDir + '\AG\Excel';
    if (NOT DirectoryExists(excelDir)) then
        ForceDirectories(excelDir);

    // Добавляем новый лист для цветного каталога
    DbMod.ExportPriceExcelFile.Workbook.Sheets.Add('Каталог');

    // Запись картинок на лист
    PrepareCatalogSheet(DbMod.ExportPriceExcelFile.Workbook.Sheets[1]);

    // На первый лист выполнить добавление сылок на картинки со второго листа
    AddLinksToImagesOnPriceSheet(DbMod.ExportPriceExcelFile.Workbook.Sheets[0]);

    // Экспортируем в формат Excel (подкаталог \Excel)
    fileName := excelDir + '\Price_' + DateToStr(Date()) + '.xls';
    DbMod.ExportPriceExcelFile.SaveToFile(fileName);

    // Очистить временную папку с изображениями
    CleanTempDir();

    // Открыть папку в которой будет располагаться архив
    { Procedure uses OS shell to open and view XLS file }
    ShellExecute(0, 'open', PChar(excelDir), nil, nil, SW_SHOW);
end;

procedure TPriceForm.PrepareExcelHeader(sheet: TSheet);
begin
    // Подготовка шапки отчета
    with sheet do
    begin
        Cells[0, 0].Value := 'AlexTechnologies';
        Cells[0, 0].FontBold := True;
        Cells[0, 0].FontColorIndex:= TXLColorIndex(23);
        Cells[0, 0].FontHeight := 24;

        Cells[1, 0].Value := 'Алексей';
        Cells[1, 0].FontBold := True;

        Cells[2, 0].Value := 'моб. +7 (910) 911-3877';
        Cells[2, 0].FontBold := True;

        Cells[3, 0].Value := 'e-mail: AlexTechnologies@gmail.com';
        Cells[3, 0].FontBold := True;
    end;
end;

// Формирует лист с каталогом изображений
procedure TPriceForm.PrepareCatalogSheet(sheet: TSheet);
var
    i, j: integer;
    blobStream: TBlobStream;
    imageSrc, imageDst: TImage;
    tempDir, tempFileName, tempExcelDir: string;
    imgIndex: String;
begin
	// определить путь к каталогу Temp
   tempDir := GetSettingsParam(Self, 'TempDir');
  	if (tempDir = '') then
   begin
   	MessageDlg('В файле настроек AppSettings.xml не задан параметр TempDir.',
      	mtError, [mbOK], 0);
   	exit;
   end;

    // Подготовка шапки листа
    with sheet do
    begin
        Cells[0, 0].Value := 'Код';
        Cells[0, 0].FillPattern:= xlPatternSolid;
        Cells[0, 0].FillPatternBGColorIndex:= TXLColorIndex(23);
        Cells[0, 0].FontColorIndex:= TXLColorIndex(2);
        Cells[0, 0].FontBold := True;

        Cells[0, 1].Value := 'Изображение';
        Cells[0, 1].FillPattern:= xlPatternSolid;
        Cells[0, 1].FillPatternBGColorIndex:= TXLColorIndex(23);
        Cells[0, 1].FontColorIndex:= TXLColorIndex(2);
        Cells[0, 1].FontBold := True;
    end;

    sheet.Columns[1].WidthPx:= 100;

    // Содержимое листа
    tempExcelDir := tempDir + '\AG\Excel\tmp';
    if (NOT DirectoryExists(tempExcelDir)) then
        ForceDirectories(tempExcelDir);

    imageSrc := TImage.Create(self);
    imageDst := TImage.Create(self);

    DbMod.QCatalogExcel.Close();
    DbMod.QCatalogExcel.Open();

    j := 1;
    // создать массив индексов с размещением картинок на листе
    imgIndexes := TStringList.Create;
    imgIndexes.Clear;
    for i := 0 to DBmod.QCatalogExcel.RecordCount do begin
        blobStream :=
            DBmod.QCatalogExcel.CreateBlobStream(
                DBmod.QCatalogExcel.FieldByName('IMAGE'), bmRead) as TBlobStream;

        IF (blobStream.Size > 0) then
        begin
            try
                blobStream.Seek(0, soFromBeginning);

                tempFileName := tempExcelDir + '\TempImage' + IntToStr(j) + '.bmp';
                imageSrc.Picture.Bitmap.LoadFromStream(blobStream);

                imageDst.Picture.Bitmap.PixelFormat := pf16bit;
                imageDst.Picture.Bitmap.Width := 100;
                imageDst.Picture.Bitmap.Height := 100;
                imageDst.Canvas.StretchDraw(Rect(0,0,100,100), imageSrc.Picture.BitMap);
                imageDst.Picture.SaveToFile(tempFileName);

                { Fit image into a cell }
                imgIndex := DBmod.QCatalogExcel.FieldByName('ID_GDS_DTL').AsString;
                sheet.Cells[j, 0].Value := imgIndex;
                sheet.Rows[j].HeightPx:= 100;
                sheet.Images.AddStretch(tempFileName, 1, j, 1, j);

                imgIndexes.Add(imgIndex);
                j := j + 1;
            finally
                if blobStream <> nil then
                    blobStream.Free;
            end;
        end;
        DBmod.QCatalogExcel.Next();
    end;
end;

procedure TPriceForm.AddLinksToImagesOnPriceSheet(sheet: TSheet);
var
    goodId: string;
    I, imageIndex: Integer;
    C: TCell;
begin
    { Enumerate rows in 1st sheet. Начиная с 7-й строки, а т.к. индекс то это 6, исключая шапку }
    DBmod.QPriceExcel.Close();
    DBmod.QPriceExcel.Open();

    for I := 6 to DBmod.QPriceExcel.RecordCount - 1 do
    begin
        C:= sheet.Cells[I, 0];
        case VarType(C.Value) of
            varInteger,
            varSmallint,
            varByte,
            varDouble,
            varSingle:
                  goodId := FloatToStr(C.Value);
            varString,
            varOleStr:
                goodId := C.Value;
        end;

        imageIndex := imgIndexes.IndexOf(goodId);
        if (imageIndex <> -1) then
        begin
            { Add link to 2nd sheet }
            C.Hyperlink:= '''Каталог''!A' + IntToStr(imageIndex + 2);
            C.HyperlinkType:= hltCurrentWorkbook;
        end;
    end;
end;

procedure TPriceForm.CleanTempDir();
var
  sr: TSearchRec;
  tempDir, tempExcelDir: string;
begin
	// определить путь к каталогу Temp
   tempDir := GetSettingsParam(Self, 'TempDir');
  	if (tempDir = '') then
   begin
   	MessageDlg('В файле настроек AppSettings.xml не задан параметр TempDir.',
      	mtError, [mbOK], 0);
   	exit;
   end;

  // почистить временный каталог
  tempExcelDir := tempDir + '\AG\Excel\tmp';

  if FindFirst(tempExcelDir+'\*.*', faAnyFile, sr) = 0 then
  repeat
    if ((sr.Name <> '.') AND (sr.Name <> '..')) then
        DeleteFile(tempExcelDir + '\' + sr.Name);
  until FindNext(SR) <> 0;
  FindClose(sr);
end;


procedure TPriceForm.DBGridEh3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{var
   gc: TGridCoord;
   old_recno: Integer;}
begin
  {if (Sender is TDBGridEh) and (Source=DBGridEh1) then
  begin
    with Sender as TDBGridEh do
    begin

      // Получить строку в таблице под мышкой
      gc := DBGridEh2.MouseCoord(X,Y);
      old_recno := DBmod.TGDS_GRP.RecNo;
      if (old_recno=gc.Y) then exit;

      DBmod.TGDS_GRP.RecNo := gc.Y;

      DBmod.TGDS_DTL.Edit();
      DBmod.TGDS_DTL.FieldByName('ID_GDS_SGRP').Value  := DBmod.TGDS_SGRP.FieldByName('ID_GDS_SGRP').Value;
      DBmod.TGDS_DTL.Post;

      // Вернутся на старую запись
      DBmod.TGDS_GRP.RecNo := old_recno;
    end;
  end;}
end;

procedure TPriceForm.DBGridEh3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   {if (Source=DBGridEh1) then Accept := true
   else Accept := false;}
   Accept := false;
end;

procedure TPriceForm.DBGridEh3CellClick(Column: TColumnEh);
begin
   RefreshGoodsDetailsTable();
end;

procedure TPriceForm.DBGridEh3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    RefreshGoodsDetailsTable();
end;

procedure TPriceForm.FormCreate(Sender: TObject);
var
    fs: String;
    mi, smi: TMenuItem;
    i,j: Integer;
    settingsValue: String;
begin
   subGroupsMain := '(прочее)';

   // Определить параметр для показа записей помеченных как удаленные из файла настроек
	showDeletedRecords := false;
	settingsValue := GetSettingsParam(Self, 'ShowDeletedRecords');
  	if AnsiCompareText(settingsValue, 'true') = 0 then
		showDeletedRecords := true;

    DBmod.TGDS_GRP.First;
    For i:= 1 to DBmod.TGDS_GRP.RecordCount do
    begin
        if DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString <> '*' then
        begin
            // добавить элементы в контекстное меню Группы
            mi := TMenuItem.Create(Self);
            mi.Name := 'grp_' + IntToStr(i);
            mi.Caption := DBmod.TGDS_GRP.FieldByName('DESCRIPTION').AsString;
            mi.Tag := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsInteger;
            subGroupsPopupMenu.Items.Add(mi);

            fs := DBmod.TGDS_GRP.FieldByName('ID_GDS_GRP').AsString;
            if fs='' then fs := '-1';

            DBmod.TGDS_SGRP.Filtered := false;
            DBmod.TGDS_SGRP.Filter := 'ID_GDS_GRP=' + fs + ' and DEL<>1';
            DBmod.TGDS_SGRP.Filtered := true;

            DBmod.TGDS_SGRP.First;
            For j:= 1 to DBmod.TGDS_SGRP.RecordCount do
            begin
                smi := TMenuItem.Create(Self);
                smi.Name := 'sgrp' + IntToStr(i) +  '_' + IntToStr(j);
                smi.Caption := DBmod.TGDS_SGRP.FieldByName('DESCRIPTION').AsString;
                smi.Tag := DBmod.TGDS_SGRP.FieldByName('ID_GDS_SGRP').AsInteger;
                smi.OnClick := subGroupsMenuItemClick;
                mi.Add(smi);

                DBmod.TGDS_SGRP.Next;
            end;

        end;
        DBmod.TGDS_GRP.Next;
    end;
    DBmod.TGDS_GRP.First;
    DBmod.TGDS_SGRP.First;
end;

procedure TPriceForm.subGroupsMenuItemClick(Sender: TObject);
var
    i: Integer;
    mi: TMenuItem;
begin
    mi := Sender as TMenuItem;
    if mi = nil then exit;

    if DBGridEh1.SelectedRows.Count = 0 then
    begin
        // изменить принадлежность к новой подгруппе
        DBmod.TGDS_DTL.Edit();
        DBmod.TGDS_DTL.FieldByName('ID_GDS_SGRP').Value  := mi.Tag;
        DBmod.TGDS_DTL.Post;

        // В новой подгруппе, к которой теперь принадлежит товар необходимо сбросить флаг Uploaded
        if DBmod.TSubgroupsWebUpdate.Locate('ID_GDS_SGRP', mi.Tag, []) then
        begin
            DBmod.TSubgroupsWebUpdate.Edit;
	         DBmod.TSubgroupsWebUpdateUPLOADED.Value := 0;
	         DBmod.TSubgroupsWebUpdate.Post;

            // В группе, в которую входит новая подгруппа необходимо сбросить флаг Uploaded
            if DBmod.TGroupsWebUpdate.Locate('ID_GDS_GRP', DBmod.TSubgroupsWebUpdateID_GDS_GRP.Value, []) then
            begin
               DBmod.TGroupsWebUpdate.Edit;
	            DBmod.TGroupsWebUpdateUPLOADED.Value := 0;
	            DBmod.TGroupsWebUpdate.Post;
            end;
        end;
    end
    else begin
        For i := 0 to DBGridEh1.SelectedRows.Count - 1 do
        begin
            // изменить принадлежность к новой подгруппе
            DBMod.TGDS_DTL.GotoBookmark(pointer(DBGridEh1.SelectedRows.Items[i]));
            DBmod.TGDS_DTL.Edit();
            DBmod.TGDS_DTL.FieldByName('ID_GDS_SGRP').Value  := mi.Tag;
            DBmod.TGDS_DTL.Post;

            // В новой подгруппе, к которой теперь принадлежит товар необходимо сбросить флаг Uploaded
            if DBmod.TSubgroupsWebUpdate.Locate('ID_GDS_SGRP', mi.Tag, []) then
            begin
               DBmod.TSubgroupsWebUpdate.Edit;
	            DBmod.TSubgroupsWebUpdateUPLOADED.Value := 0;
	            DBmod.TSubgroupsWebUpdate.Post;

               // В группе, в которую входит новая подгруппа необходимо сбросить флаг Uploaded
               if DBmod.TGroupsWebUpdate.Locate('ID_GDS_GRP', DBmod.TSubgroupsWebUpdateID_GDS_GRP.Value, []) then
               begin
                  DBmod.TGroupsWebUpdate.Edit;
	               DBmod.TGroupsWebUpdateUPLOADED.Value := 0;
	               DBmod.TGroupsWebUpdate.Post;
               end;
            end;
        end;
    end;
end;

procedure TPriceForm.MakeTGDSColumsReadOnly(flag: boolean);
var
   i: Integer;
begin
   addSubgroupButton.Enabled := Not flag;
   deleteSubgroupButton.Enabled := Not flag;
   addGoodsButton.Enabled := Not flag;

   DBGridEh3.ReadOnly := flag;
   DBGridEh2.ReadOnly := flag;

   for i:=0 to DBGridEh1.Columns.Count - 1  do begin
      // колонка Цена доступна для редактирования всегда
      if (i = 6) then
         DBGridEh1.Columns.Items[i].ReadOnly := false
      // колонки Группа/Подгруппа видны только когда выбрана группа '*'
      else if (i = 10) OR (i = 11) then
         DBGridEh1.Columns.Items[i].Visible := flag
      else
         DBGridEh1.Columns.Items[i].ReadOnly := flag;
   end
end;

procedure TPriceForm.deleteSubgroupButtonClick(Sender: TObject);
var
   i: integer;
begin
   { WARNING:>
     Обязательно сделать проверку на использование ссылки на товар в табл.:
     Накладные, Склад, Учет.
   }
   if (DBmod.TGDS_SGRP.RecordCount=0) then
    exit;

   if MessageDlg('Хотите удалить подгруппу <'+ DBmod.TGDS_SGRP.FieldByName('DESCRIPTION').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;

   //isdel := false;
   if (DBmod.TGDS_DTL.RecordCount<>0) then
   begin
      // Поиск товаров данной подгруппы в "Накладных" и на "Складе"
      // + добавил проверку на то, что товар уже выгружен на веб-сайт (следовательно удаление должно отработать и на веб-саате)
      for i:=1 to DBmod.TGDS_DTL.RecordCount do begin

         // !!! В целях синхронизации с сайтом группа, подгруппа и товар всегда только помечаются как удаленные

         //if ((DBmod.TSLS_DTL.Locate('ID_GDS_DTL',DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value,[])) or
         //    (DBmod.TSTR.Locate('ID_GDS_DTL',DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value,[])) or
         //    (DBmod.TGDS_DTL.FieldByName('UPLOADED').AsInteger = 1)) then
         //begin
            // хотя запись и помечается как удаленная, необходимо очистить поле IMAGE (т.к. занимает много места в БД)
            popupItemClearPictureClick(Self);

            DBmod.TGDS_DTL.Edit;
            DBmod.TGDS_DTL.FieldByName('DEL').Value := 1;
            DBmod.TGDS_DTL.Post;
            //isdel := true
         //end
         //else
         //   DBmod.TGDS_DTL.Delete; // товар не найден
      end;
   end;

   //if (isdel = true) then
   //begin
        DBmod.TGDS_SGRP.Edit;
        DBmod.TGDS_SGRP.FieldByName('DEL').Value := 1;
        DBmod.TGDS_SGRP.Post;
   //end
   //else
   //     DBmod.TGDS_SGRP.Delete;

   DBmod.TGDS_DTL.FlushBuffers;

   RefreshGoodsDetailsTable();
end;

procedure TPriceForm.deleteBadBlobClick(Sender: TObject);
var
   i: integer;
   blobStream: TBlobStream;
   img: TImage;
begin
    img := TImage.Create(Self);

    DBmod.TGDS_DTL.First;
    for i:=1 to DBmod.TGDS_DTL.RecordCount do
    begin
        if DBmod.TGDS_DTLIMAGE.BlobSize > 0 then
        begin
            blobStream :=
                DBmod.TGDS_DTL.CreateBlobStream(
                    DBmod.TGDS_DTL.FieldByName('IMAGE'), bmRead) as TBlobStream;
            try
                try
                    blobStream.Seek(0, soFromBeginning);
                    img.Picture.Bitmap.LoadFromStream(blobStream);
                except
                    on E: Exception do
                    begin
                        popupItemClearPictureClick(Self);
                        ShowMessage('Удалено изображение для записи: ' + DBmod.TGDS_GRP.FieldByName('ID_GDS_DTL').AsString);
                    end;
                end;
            finally
                if blobStream <> nil then
                    blobStream.Free;
            end;
        end;
        DBmod.TGDS_DTL.Next;
    end;
end;

function TPriceForm.SplitString(const Original: String; Splitter: Char): TStringList;
var
   source: String;
begin
   // input string normalization
   source := Original;
   if Pos(',', source) = 1 then
      Delete(source, 1, 1);
   if Pos(',', source) = Length(source) then
      Delete(source, Length(source), 1);

   Result := TStringList.Create;
   Result.CommaText := source;
   //Result.Delimiter := ';';
   //ExtractStrings([','], [], PChar(source), Result);
end;

procedure TPriceForm.SerializeDiscountsUpdate(updatesRoot: IXMLNode);
var
   i: integer;
   deleted: boolean;
   discountsRoot, discountItem: IXMLNode;
begin
   discountsRoot := updatesRoot.AddChild('Discounts');
   DBMod.TDiscounts.First;
   for i := 1 to DBMod.TDiscounts.RecordCount do
   begin
      if (DBMod.TDiscountsUPLOADED.Value = 0) then
      begin
         if DBmod.TDiscountsDEL.Value = 1 then deleted := true else deleted := false;

         discountItem := discountsRoot.AddChild('DiscountItem');
         discountItem.SetAttributeNS('id', '', DBmod.TDiscountsID_COST_DCT.Value);
         discountItem.SetAttributeNS('startSumm', '', DBmod.TDiscountsSTART_SUMM.Value);
         discountItem.SetAttributeNS('del', '', deleted);
      end;

      DBMod.TDiscounts.Next;
   end;
end;

procedure TPriceForm.uploadWebButtonClick(Sender: TObject);
var
  	Xml: IXMLDocument;
  	root, groupItem, subGroupItem, goodsItem, discounts: IXMLNode;
  	i, j, k: integer;
  	deleted: boolean;
  	tempDir, exportDir, cloudUploaderExePath: string;
  	exportDate: TDateTime;
  	y, m, d, h, min, s, ms : Word;
  	uniqueExportName: string;
  	blobStream: TBlobStream;
   errorCode: DWord;
   groupIds4Update, subgroupIds4Update, goodIds4Update: String;
   groups4Update, subgroups4Update, goods4Update: TStringList;
   counter: integer;
begin
  	{ Необходимо учесть:
  	  При обновлении подгруппы должен быть снят флаг Uploaded в таблице Групп.
  	  Аналогично при изменении записи в таблице товаров должен быть снят флаг Uploaded в таблицах Групп и Подгрупп }

   if MessageDlg('Вы действительно хотите обновить содержимое веб-сайта?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

	// определить путь к каталогу Temp
   tempDir := GetSettingsParam(Self, 'TempDir');
  	if (tempDir = '') then
   begin
   	MessageDlg('В файле настроек AppSettings.xml не задан параметр TempDir.',
      	mtError, [mbOK], 0);
   	exit;
   end;

   exportDate := Now;
   DecodeTime(exportDate, h, min, s, ms);
   DecodeDate(exportDate, y, m, d);
   uniqueExportName := IntToStr(d) + '.' + IntToStr(m) + '.' + IntToStr(y) + '_' + IntToStr(h) + IntToStr(min) + IntToStr(s);
   exportDir := tempDir + '\AG\web\' + uniqueExportName;

   if NOT DirectoryExists(exportDir) then
   	ForceDirectories(exportDir);

  	Xml := TXMLDocument.Create(Self);
  	Xml.Active := true;
  	Xml.Options := [doNodeAutoIndent];

  	DBmod.QGroupsWeb.Close();
  	DBmod.QGroupsWeb.Open();
  	DBmod.QGroupsWeb.First;

  	root := Xml.AddChild('Update');

   // add information about discounts
   SerializeDiscountsUpdate(root);

   try
	   DBmod.g_uploading := true;
   	//---------------------------------------------------
   	for i := 1 to DBMod.QGroupsWeb.RecordCount do
   	begin
      	// если группа с именем '*', не обрабатывать эту группу
      	if (DBmod.QGroupsWebDESCRIPTION.Value = '*') then
      	begin
	      	DBMod.QGroupsWeb.Next;
         	continue;
      	end;

      	if DBmod.QGroupsWebDEL.Value = 1 then deleted := true else deleted := false;

      	groupItem := root.AddChild('GroupItem');
      	groupItem.SetAttributeNS('id', '', DBmod.QGroupsWebID_GDS_GRP.Value);
      	groupItem.SetAttributeNS('title', '', DBmod.QGroupsWebDESCRIPTION.Value);
      	groupItem.SetAttributeNS('deleted', '', deleted);

         // запомнить идентификатор группы
         groupIds4Update := Concat(groupIds4Update, ',', DBmod.QGroupsWebID_GDS_GRP.AsString);

         // обработка подгрупп данной группы
   	   DBmod.QSubgroupsWeb.Close();
	      DBmod.QSubgroupsWeb.ParamByName('A').Value := DBMod.QGroupsWebID_GDS_GRP.Value;
	      DBmod.QSubgroupsWeb.Open();
	      DBmod.QSubgroupsWeb.First;

	      for j := 1 to DBMod.QSubgroupsWeb.RecordCount do
      	begin
		      if DBmod.QSubgroupsWebDEL.Value = 1 then deleted := true else deleted := false;

         	subGroupItem := groupItem.AddChild('SubgroupItem');
	         subGroupItem.SetAttributeNS('id', '', DBmod.QSubgroupsWebID_GDS_SGRP.Value);
	         subGroupItem.SetAttributeNS('title', '', DBmod.QSubgroupsWebDESCRIPTION.Value);
	         subGroupItem.SetAttributeNS('deleted', '', deleted);

            // запомнить идентификатор подгруппы
            subgroupIds4Update := Concat(subgroupIds4Update, ',', DBmod.QSubgroupsWebID_GDS_SGRP.AsString);

            // обработка товаров данной подгруппы
         	DBmod.QGoodsWeb.Close();
         	DBmod.QGoodsWeb.ParamByName('A').Value := DBMod.QSubgroupsWebID_GDS_SGRP.Value;
         	DBmod.QGoodsWeb.Open();
         	DBmod.QGoodsWeb.First;

         	for k := 1 to DBMod.QGoodsWeb.RecordCount do
         	begin
	      		if DBmod.QGoodsWebDEL.Value = 1 then deleted := true else deleted := false;

	            // save picture to file
              if DBmod.QGoodsWebIMAGE_SET.Value = 1 then
              begin
  		        	blobStream :=
  	            	DBmod.QGoodsWeb.CreateBlobStream(
	                 	DBmod.QGoodsWeb.FieldByName('IMAGE'), bmRead) as TBlobStream;
     	          ExportImageToFile(exportDir + '\' + DBmod.QGoodsWebID_GDS_DTL.AsString + '.jpg', blobStream);
              end;

	         	goodsItem := subGroupItem.AddChild('GoodsItem');
	         	goodsItem.SetAttributeNS('id', '', DBmod.QGoodsWebID_GDS_DTL.Value);
	         	goodsItem.SetAttributeNS('title', '', DBmod.QGoodsWebDESCRIPTION.Value);
	            goodsItem.SetAttributeNS('mu', '', DBmod.QGoodsWebMeasureUnits.Value);
	            goodsItem.SetAttributeNS('pack', '', DBmod.QGoodsWebPACK_NUM.Value);
	            goodsItem.SetAttributeNS('costWhs1', '', DBmod.QGoodsWebCOST_WHS1.Value);
               goodsItem.SetAttributeNS('costWhs2', '', DBmod.QGoodsWebCOST_WHS2.Value);
               goodsItem.SetAttributeNS('costWhs3', '', DBmod.QGoodsWebCOST_WHS3.Value);
	         	goodsItem.SetAttributeNS('img', '', DBmod.QGoodsWebID_GDS_DTL.AsString + '.jpg');
	            goodsItem.SetAttributeNS('deleted', '', deleted);

               // запомнить идентификатор товара
               goodIds4Update := Concat(goodIds4Update, ',', DBmod.QGoodsWebID_GDS_DTL.AsString);

	            DBMod.QGoodsWeb.Next;

               counter := counter + 1;
   	      end;

            // перейти к следующей подгруппе
          	DBMod.QSubgroupsWeb.Next;
      	end;

         // перейти к следующей группе
	      DBMod.QGroupsWeb.Next;
	   end;
   finally
      DBmod.g_uploading := false;
   end;

  	Xml.SaveToFile(exportDir + '\Update_' + uniqueExportName + '.xml');
  	Xml.Active := false;

   // Запустить утилиту загрузки экспортируемых данных в Cloud
   cloudUploaderExePath := ExtractFilePath(ParamStr(0)) + 'CloudUploader\Altech.CloudUploader.exe';
   errorCode := ShellExecAndWait(cloudUploaderExePath, exportDir); 
   if (errorCode <> 0) then
   begin
   	MessageDlg('При отправке обновления в Cloud произошла ошибка. Обратитесь к разработчику. Код ошибки: ' + IntToStr(errorCode),
      	mtError, [mbOK], 0);
   	exit;
   end;

   // выставить флаг выгрзуки товара
   goods4Update := SplitString(goodIds4Update, ';');
   for k := 0 to goods4Update.Count-1 do
   begin
      if not DBmod.TGoodsWebUpdate.Locate('ID_GDS_DTL', StrToInt(goods4Update[k]), []) then
      begin
         MessageDlg('Внутренняя ошибка - не удается найти запись в табилце Товары. ID=' + DBmod.QGoodsWebID_GDS_DTL.AsString,
            mtError, [mbOK], 0);
         exit;
      end;
      DBmod.TGoodsWebUpdate.Edit;
      DBmod.TGoodsWebUpdateUPLOADED.Value := 1;
      DBmod.TGoodsWebUpdateIMAGE_SET.Value := 0;
      DBmod.TGoodsWebUpdate.Post;
   end;
   goods4Update.Free;

   // выставить флаг выгрзуки подгруппы
   subgroups4Update := SplitString(subgroupIds4Update, ';');
   for j := 0 to subgroups4Update.Count-1 do
   begin
      if not DBmod.TSubgroupsWebUpdate.Locate('ID_GDS_SGRP', StrToInt(subgroups4Update[j]), []) then
      begin
         MessageDlg('Внутренняя ошибка - не удается найти запись в табилце Подгруппы. ID=' + DBmod.QSubgroupsWebID_GDS_SGRP.AsString,
            mtError, [mbOK], 0);
         exit;
      end;
      DBmod.TSubgroupsWebUpdate.Edit;
      DBmod.TSubgroupsWebUpdateUPLOADED.Value := 1;
      DBmod.TSubgroupsWebUpdate.Post;
   end;
   subgroups4Update.Free;

   // выставить флаг выгрзуки Группы
   groups4Update := SplitString(groupIds4Update, ';');
   for i := 0 to groups4Update.Count-1 do
   begin
      if not DBmod.TGroupsWebUpdate.Locate('ID_GDS_GRP', StrToInt(groups4Update[i]), []) then
      begin
         MessageDlg('Внутренняя ошибка - не удается найти запись в табилце Группы. ID=' + DBmod.QGroupsWebID_GDS_GRP.AsString,
            mtError, [mbOK], 0);
         exit;
      end;
      DBmod.TGroupsWebUpdate.Edit;
      DBmod.TGroupsWebUpdateUPLOADED.Value := 1;
      DBmod.TGroupsWebUpdate.Post;
   end;
   groups4Update.Free;

   // удалить директорию
   RemoveDir(exportDir);

   MessageDlg('Обновление отправлено на веб-сайт. Через некоторое время сайт будет обновлен.',
      mtInformation, [mbOK], 0);

   RefreshSubgroupsTable();
end;

function TPriceForm.ShellExecAndWait(ExeFile: string; Parameters: string = ''; ShowWindow: Word = SW_SHOWNORMAL): DWord;
  //----------------------------------------
  procedure WaitFor(processHandle: THandle);
  var
    AMessage : TMsg;
    Result   : DWord;
  begin
    repeat
      Result := MsgWaitForMultipleObjects(1,
                                          processHandle,
                                          False,
                                          INFINITE,
                                          QS_PAINT or
                                          QS_SENDMESSAGE);
      if Result = WAIT_FAILED then
        Exit;
      if Result = ( WAIT_OBJECT_0 + 1 ) then
      begin
        while PeekMessage(AMessage, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
          DispatchMessage(AMessage);
      end;
    until result = WAIT_OBJECT_0;
  end;
  //----------------------------------------
var
  ExecuteCommand: array[0 .. 512] of Char;
  PathToExeFile : string;
  StartUpInfo   : TStartupInfo;
  ProcessInfo   : TProcessInformation;
  ProcessExitCode: DWord;
begin
   Result := 0;
   StrPCopy(ExecuteCommand , ExeFile + ' ' + Parameters);
   FillChar(StartUpInfo, SizeOf(StartUpInfo), #0);
   StartUpInfo.cb  := SizeOf(StartUpInfo);
   StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartUpInfo.wShowWindow := ShowWindow;//SW_SHOWNORMAL; //SW_MINIMIZE;
   PathToExeFile := ExtractFileDir(ExeFile);
   if CreateProcess(nil,
                   ExecuteCommand,
                   nil,
                   nil,
                   False,
                   CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                   nil,
                   PChar(PathToExeFile),
                   StartUpInfo,
                   ProcessInfo) then
   begin
      WaitFor(ProcessInfo.hProcess);

      if Windows.GetExitCodeProcess(ProcessInfo.hProcess, ProcessExitCode) then
         Result := ProcessExitCode;
   end
   else
      Result := 99;
end;

procedure TPriceForm.ExportImageToFile(fileName: string; blobStream: TBlobStream);
var
	img: TImage;
begin
   try
      IF blobStream.Size <> 0 then
      begin
   	   blobStream.Seek(0, soFromBeginning);

      	img := TImage.Create(self);
	      img.Picture.Bitmap.LoadFromStream(blobStream);
	      img.Picture.SaveToFile(fileName);
      end;
   finally
		if blobStream <> nil then
      	blobStream.Free;
   end;
end;

procedure TPriceForm.popupItemStoreClick(Sender: TObject);
begin
    ShowStoreView();
end;

procedure TPriceForm.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
	if DBmod.TGDS_DTLDEL.Value = 1 then
   begin
   	DBGridEh1.Canvas.Brush.Color := $00ECECFF;//$00E6E6FF;
      DBGridEh1.Canvas.Font.Color := clGrayText;
      DBGridEh1.Canvas.Font.Style := [fsItalic];
   end;

   DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TPriceForm.DBGridEh1SortMarkingChanged(Sender: TObject);
var
   field: String;
   sortIndex: String;
begin
	if (Sender as TDBGridEh).SortMarkedColumns.Count = 0 then
   	exit;

   field := (Sender as TDBGridEh).SortMarkedColumns.Items[0].FieldName;
   if (Sender as TDBGridEh).SortMarkedColumns.Items[0].Title.SortMarker = smUpEh then
   	sortIndex := field + '_asc'
   else
   	sortIndex := field + '_desc';

   DBmod.TGDS_DTL.IndexName := sortIndex;
end;

procedure TPriceForm.addGroupButtonClick(Sender: TObject);
begin
   DBMod.TGDS_GRP.Insert;
end;

procedure TPriceForm.addSubgroupButtonClick(Sender: TObject);
begin
   DBMod.TGDS_SGRP.Insert;
end;

procedure TPriceForm.addGoodsButtonClick(Sender: TObject);
begin
   DBMod.TGDS_DTL.Insert;
end;

procedure TPriceForm.discountsButtonClick(Sender: TObject);
begin
   DiscountsForm.ShowModal;
end;

end.
