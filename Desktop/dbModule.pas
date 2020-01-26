unit dbModule;

interface

uses
  Windows, Messages, SysUtils, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, FR_Shape, FR_DSet, FR_DBSet, FR_Class, extctrls,
  XLSExportComp, Classes;

type
  TDBmod = class(TDataModule)
    TGDS_GRP: TTable;
    DGDS_GRP: TDataSource;
    TGDS_DTL: TTable;
    DGDS_DTL: TDataSource;
    TGDS_GRPID_GDS_GRP: TAutoIncField;
    TGDS_GRPDESCRIPTION: TStringField;
    TGDS_GRPDEL: TIntegerField;
    TGDS_DTLID_GDS_DTL: TAutoIncField;
    TGDS_DTLDESCRIPTION: TStringField;
    TGDS_DTLDEL: TIntegerField;
    frReport1: TfrReport;
    frPrice: TfrDBDataSet;
    QPrice: TQuery;
    frShapeObject1: TfrShapeObject;
    TCST: TTable;
    DCST: TDataSource;
    TSLS_GRP: TTable;
    DSLS_GRP: TDataSource;
    TSLS_DTL: TTable;
    DSLS_DTL: TDataSource;
    TSLS_DTLID_SLE_DTL: TAutoIncField;
    TSLS_DTLID_SLE_GRP: TIntegerField;
    TSLS_DTLID_GDS_DTL: TIntegerField;
    TSLS_DTLGDS_NUMB: TIntegerField;
    TINF: TTable;
    TINFAbout: TStringField;
    frNakl: TfrDBDataSet;
    QNakl: TQuery;
    TSLS_GRPID_SAL_GRP: TAutoIncField;
    TSLS_GRPID_CST: TIntegerField;
    TSLS_GRPSDATE: TDateField;
    TSLS_GRPSALE_SUM: TCurrencyField;
    Database1: TDatabase;
    TSKD_GRP: TTable;
    DSKD_GRP: TDataSource;
    TSKD_DTL: TTable;
    DSKD_DTL: TDataSource;
    TSKD_GRPID_SKL_GRP: TAutoIncField;
    TSKD_GRPDESCRIPRION: TStringField;
    TSKD_GRPSDATE: TStringField;
    TSKD_DTLID_SKL_DTL: TAutoIncField;
    TSKD_DTLID_SKL_GRP: TIntegerField;
    TSKD_DTLID_GDS_GRP: TIntegerField;
    TSKD_DTLID_GDS_DTL: TIntegerField;
    TSKD_DTLGDS_DESCR: TStringField;
    TSKD_DTLNUMBER: TIntegerField;
    QSklad: TQuery;
    QSkladDESCRIPRION: TStringField;
    QSkladSDATE: TStringField;
    QSkladGDS_DESCR: TStringField;
    QSkladNUMBER: TIntegerField;
    frSklad: TfrDBDataSet;
    TINFNDS: TFloatField;
    TEE: TTable;
    TEESeller: TStringField;
    TEEAddress: TStringField;
    TEEINN: TStringField;
    TEERsht: TStringField;
    TEEBik: TStringField;
    TEEKsht: TStringField;
    TSLS_DTLGDS_COST_NDS: TCurrencyField;
    TSLS_DTLGDS_COST_CLR: TCurrencyField;
    TOKEY: TTable;
    DOKEY: TDataSource;
    TOKEYID_OKEY: TAutoIncField;
    TOKEYNAME: TStringField;
    TOKEYDESCRIPTION: TStringField;
    TOKEYVALUE: TStringField;
    TGDS_DTLID_OKEY: TIntegerField;
    TGDS_DTLUnitMeasuring: TStringField;
    TGDS_DTLIMAGE: TGraphicField;
    TGDS_DTLImageType: TIntegerField;
    QNaklCokey: TStringField;
    QNaklUnit: TStringField;
    QNaklSDATE: TDateField;
    QNaklGDS_DESCR: TStringField;
    QNaklGDS_COST_NDS: TCurrencyField;
    QNaklGDS_COST_CLR: TCurrencyField;
    QNaklGDS_NUMB: TIntegerField;
    frInvoice: TfrDBDataSet;
    QNaklID_GDS_DTL: TIntegerField;
    ExportPriceExcelFile: TXLSExportFile;
    XLSExportPriceDataSource: TXLSExportDataSource;
    DQPriceExcel: TDataSource;
    QPriceExcel: TQuery;
    QCatalogExcel: TQuery;
    DQCatalogExcel: TDataSource;
    QCatalogExcelID_GDS_DTL: TIntegerField;
    QCatalogExcelIMAGE: TGraphicField;
    XLSExportNakladnayaDataSource: TXLSExportDataSource;
    DQNakladnayaExcel: TDataSource;
    ExportNakladnayaExcelFile: TXLSExportFile;
    QNakladnayaExcel: TQuery;
    QNakladnayaExcelID_GDS_DTL: TIntegerField;
    QNakladnayaExcelGDS_DESCR: TStringField;
    QNakladnayaExcelGDS_COST_CLR: TCurrencyField;
    QNakladnayaExcelGDS_NUMB: TIntegerField;
    QNakladnayaExcelSDATE: TDateField;
    TGDS_SGRP: TTable;
    TGDS_DTLID_GDS_SGRP: TIntegerField;
    TGDS_SGRPID_GDS_SGRP: TAutoIncField;
    TGDS_SGRPDESCRIPTION: TStringField;
    TGDS_SGRPDEL: TIntegerField;
    DGDS_SGRP: TDataSource;
    TGDS_SGRPID_GDS_GRP: TIntegerField;
    QPriceExcelID_GDS_DTL: TIntegerField;
    QPriceExceldtl_description: TStringField;
    TGDS_DTLPACK_NUM: TIntegerField;
    QPriceExcelPACK_NUM: TIntegerField;
    QPriceExcelsgrp_description: TStringField;
    TSTR: TTable;
    DSTR: TDataSource;
    TSTRID_STR: TAutoIncField;
    TSTRID_GDS_DTL: TIntegerField;
    TSTRNUM: TIntegerField;
    TSLS_GRPSTORE_CHECK: TIntegerField;
    TGDS_DTLSTORE_NUM: TIntegerField;
    QSTR: TQuery;
    QSTRDESCRIPTION: TStringField;
    QSTRNUM: TIntegerField;
    QSTRID_GDS_DTL: TIntegerField;
    TGDS_GRPUPLOADED: TIntegerField;
    TGDS_SGRPUPLOADED: TIntegerField;
    TGDS_DTLWARE_NUM: TIntegerField;
    TGDS_DTLUPLOADED: TIntegerField;
    QGroupsWeb: TQuery;
    QSubgroupsWeb: TQuery;
    QGoodsWeb: TQuery;
    QSubgroupsWebID_GDS_GRP: TIntegerField;
    QSubgroupsWebDESCRIPTION: TStringField;
    QSubgroupsWebDEL: TIntegerField;
    QGroupsWebID_GDS_GRP: TIntegerField;
    QGroupsWebDESCRIPTION: TStringField;
    QGroupsWebDEL: TIntegerField;
    QSubgroupsWebID_GDS_SGRP: TIntegerField;
    TGroupsWebUpdate: TTable;
    TSubgroupsWebUpdate: TTable;
    TGoodsWebUpdate: TTable;
    TGroupsWebUpdateID_GDS_GRP: TAutoIncField;
    TGroupsWebUpdateDESCRIPTION: TStringField;
    TGroupsWebUpdateDEL: TIntegerField;
    TGroupsWebUpdateUPLOADED: TIntegerField;
    TSubgroupsWebUpdateID_GDS_SGRP: TAutoIncField;
    TSubgroupsWebUpdateDESCRIPTION: TStringField;
    TSubgroupsWebUpdateDEL: TIntegerField;
    TSubgroupsWebUpdateID_GDS_GRP: TIntegerField;
    TSubgroupsWebUpdateUPLOADED: TIntegerField;
    TGoodsWebUpdateID_GDS_DTL: TAutoIncField;
    TGoodsWebUpdateID_GDS_SGRP: TIntegerField;
    TGoodsWebUpdateID_OKEY: TIntegerField;
    TGoodsWebUpdateDESCRIPTION: TStringField;
    TGoodsWebUpdateWARE_NUM: TIntegerField;
    TGoodsWebUpdateIMAGE: TGraphicField;
    TGoodsWebUpdateDEL: TIntegerField;
    TGoodsWebUpdatePACK_NUM: TIntegerField;
    TGoodsWebUpdateUPLOADED: TIntegerField;
    QGoodsWebID_GDS_DTL: TIntegerField;
    QGoodsWebID_GDS_SGRP: TIntegerField;
    QGoodsWebDESCRIPTION: TStringField;
    QGoodsWebMeasureUnits: TStringField;
    QGoodsWebIMAGE: TGraphicField;
    QGoodsWebPACK_NUM: TIntegerField;
    QGoodsWebDEL: TIntegerField;
    TGDS_DTLWeb: TIntegerField;
    QNaklCompany: TStringField;
    TSLS_GRPID_WEB: TIntegerField;
    TSLS_DTLComment: TStringField;
    TGDS_DTLCOST_PURCH: TCurrencyField;
    TGDS_SGRPGroupName: TStringField;
    QGoodsCategory: TQuery;
    QGoodsCategoryID_GDS_DTL: TIntegerField;
    QGoodsCategoryGroupName: TStringField;
    QGoodsCategorySubgroupName: TStringField;
    TGDS_DTLGroupName: TStringField;
    TGDS_DTLSubgroupName: TStringField;
    TGDS_DTLCOST_WHS1: TCurrencyField;
    TGDS_DTLCOST_WHS2: TCurrencyField;
    TGDS_DTLCOST_WHS3: TCurrencyField;
    TDiscounts: TTable;
    TDiscountsID_COST_DCT: TIntegerField;
    TDiscountsPROFIT_PERCENTAGE: TFloatField;
    TDiscountsSTART_SUMM: TCurrencyField;
    DDiscounts: TDataSource;
    TINFOrderCounter: TIntegerField;
    TSLS_GRPOrderNo: TIntegerField;
    TGoods4Orders: TTable;
    TGoods4OrdersID_GDS_DTL: TAutoIncField;
    TGoods4OrdersDESCRIPTION: TStringField;
    QGoodsWebCOST_WHS1: TCurrencyField;
    QGoodsWebCOST_WHS2: TCurrencyField;
    QGoodsWebCOST_WHS3: TCurrencyField;
    TGoodsWebUpdateCOST_PURCH: TCurrencyField;
    TGoodsWebUpdateCOST_WHS1: TCurrencyField;
    TGoodsWebUpdateCOST_WHS2: TCurrencyField;
    TGoodsWebUpdateCOST_WHS3: TCurrencyField;
    TDiscountsUPLOADED: TIntegerField;
    TDiscountsDEL: TIntegerField;
    TGDS_DTLIMAGE_SET: TIntegerField;
    QGoodsWebIMAGE_SET: TIntegerField;
    TGoodsWebUpdateIMAGE_SET: TIntegerField;
    QCustomerLookup: TQuery;
    QCustomerLookupID_CST: TIntegerField;
    QPriceLookup: TQuery;
    QPriceLookupID_GDS_DTL: TIntegerField;
    TCSTID_CST: TAutoIncField;
    TCSTCompany: TStringField;
    TCSTContactName: TStringField;
    TCSTINN: TStringField;
    TCSTAddress: TStringField;
    TCSTDel: TIntegerField;
    TCSTOpt: TIntegerField;
    TCSTPhone: TStringField;
    TCSTEmail: TStringField;
    TCSTGuid: TStringField;
    TCSTID_COST_DCT: TIntegerField;
    TCSTProfitPercentage: TIntegerField;
    QNakladnayaExcelOKCODE: TStringField;
    QPriceExcelCOST_WHS1: TCurrencyField;
    QPriceExcelCOST_WHS2: TCurrencyField;
    QPriceExcelCOST_WHS3: TCurrencyField;
    TSLS_DTLTitle: TStringField;
    TSLS_GRPCashlessPayment: TIntegerField;
    TGDS_DTLMIN_PACK: TIntegerField;
    QPriceID_GDS_DTL: TIntegerField;
    QPriceIMAGE: TGraphicField;
    QPricedtl_description: TStringField;
    QPriceCOST_WHS1: TCurrencyField;
    QPriceCOST_WHS2: TCurrencyField;
    QPriceCOST_WHS3: TCurrencyField;
    QPricePACK_NUM: TIntegerField;
    QPriceMIN_PACK: TIntegerField;
    QPricesgrp_description: TStringField;
    QGoodsWebMIN_PACK: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TGDS_DTLBeforePost(DataSet: TDataSet);
    procedure TGDS_GRPBeforePost(DataSet: TDataSet);
    procedure TGDS_DTLAfterInsert(DataSet: TDataSet);
    procedure TGDS_DTLAfterDelete(DataSet: TDataSet);
    procedure TCSTAfterPost(DataSet: TDataSet);
    procedure TCSTBeforeInsert(DataSet: TDataSet);
    procedure TSLS_GRPAfterPost(DataSet: TDataSet);
    procedure TCSTAfterCancel(DataSet: TDataSet);
    procedure TSLS_GRPBeforePost(DataSet: TDataSet);
    procedure frReport1UserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure TGDS_DTLBeforeInsert(DataSet: TDataSet);
    procedure TGDS_DTLBeforeEdit(DataSet: TDataSet);
    procedure TGDS_GRPBeforeInsert(DataSet: TDataSet);
    procedure TGDS_GRPBeforeEdit(DataSet: TDataSet);
    procedure TGDS_DTLAfterPost(DataSet: TDataSet);
    procedure TGDS_DTLBeforeDelete(DataSet: TDataSet);
    procedure TGDS_GRPAfterPost(DataSet: TDataSet);
    procedure TSLS_DTLBeforePost(DataSet: TDataSet);
    procedure TSKD_DTLAfterInsert(DataSet: TDataSet);
    procedure TSKD_DTLAfterPost(DataSet: TDataSet);
    procedure TSKD_DTLAfterEdit(DataSet: TDataSet);
    procedure TSKD_DTLAfterDelete(DataSet: TDataSet);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure TGDS_DTLCalcFields(DataSet: TDataSet);
    procedure XLSExportPriceDataSourceSaveTitle(FieldIndex: Integer;
      XLSCell: TCell);
    procedure XLSExportNakladnayaDataSourceSaveTitle(FieldIndex: Integer;
      XLSCell: TCell);
    procedure TGDS_SGRPBeforeEdit(DataSet: TDataSet);
    procedure TGDS_SGRPBeforeInsert(DataSet: TDataSet);
    procedure TGDS_SGRPBeforePost(DataSet: TDataSet);
    procedure TGDS_SGRPAfterPost(DataSet: TDataSet);
    procedure TDiscountsBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    function DefineImageHeight(): integer;
  public
    { Public declarations }
    //id_cust: integer;
    //sdate: TDate;
    extra_mode: boolean;
    store_transfer: boolean;
    g_uploading: boolean;

    procedure DBControl(b: boolean);
    procedure SklafGroupUpdate();
    function FloatToPKOrder(sum: real): String;
  end;

var
  DBmod: TDBmod;
  ggrp_ins, gsgrp_ins, gdtl_ins: boolean;

implementation

uses MAIN, Nakladnaya, Sum_Propis_3, NDS_Params, XLSFormat, XLSWorkbook;

{$R *.DFM}
procedure TDBmod.DataModuleCreate(Sender: TObject);
begin
   DBControl(true);

   if Database1.InTransaction = false then
	   Database1.StartTransaction;

   store_transfer := false;
   extra_mode := false;
   g_uploading := false;
end;

procedure TDBmod.DBControl(b: boolean);
begin
   Database1.Connected := b;

   TINF.Active := b;
   TGDS_GRP.Active := b;
   TGDS_SGRP.Active := b;
   TGDS_DTL.Active := b;
   TDiscounts.Active := b;

   TCST.Active     := b;
   TSLS_GRP.Active := b;
   TSLS_DTL.Active := b;
   TGoods4Orders.Active := b;

   TSTR.Active := b;

   TGoodsWebUpdate.Active := b;
   TGroupsWebUpdate.Active := b;
   TSubgroupsWebUpdate.Active := b;
end;

procedure TDBmod.DataModuleDestroy(Sender: TObject);
begin
	if Database1.InTransaction = true then
   	Database1.Commit;

   DBControl(false);
end;

procedure TDBmod.TGDS_DTLBeforePost(DataSet: TDataSet);
var
   whsp1, whsp2, whsp3: real;
begin
	if Database1.InTransaction = false then
	   Database1.StartTransaction;

   if gdtl_ins=true then
   begin
       TGDS_DTL.FieldByName('ID_GDS_SGRP').Value := TGDS_SGRP.FieldByName('ID_GDS_SGRP').Value;
       TGDS_DTL.FieldByName('DEL').Value := 0;
   end;

   // Если в текущий момент не выполняется обновление сайта,
   // то это режим редактирования записей и флаг Uploaded сбрабсывается
   if g_uploading = false then
   begin

       // определение величин накруток в процентах для трех типов цен
       if (TDiscounts.Locate('ID_COST_DCT',1,[])) then
         whsp1 := TDiscounts.FieldByName('PROFIT_PERCENTAGE').Value
       else
         whsp1 := 50;
       if (TDiscounts.Locate('ID_COST_DCT',2,[])) then
         whsp2 := TDiscounts.FieldByName('PROFIT_PERCENTAGE').Value
       else
         whsp2 := 30;
       if (TDiscounts.Locate('ID_COST_DCT',3,[])) then
         whsp3 := TDiscounts.FieldByName('PROFIT_PERCENTAGE').Value
       else
         whsp3 := 20;

       // расчет оптовых цен на основе цены закупки и накруток
       if (TGDS_DTL.FieldByName('COST_PURCH').Value > 0) then
       begin
         if (TGDS_DTL.FieldByName('COST_WHS1').Value = 0) then
            TGDS_DTL.FieldByName('COST_WHS1').Value :=
               TGDS_DTL.FieldByName('COST_PURCH').Value + TGDS_DTL.FieldByName('COST_PURCH').Value * whsp1 / 100;
         if (TGDS_DTL.FieldByName('COST_WHS2').Value = 0) then
            TGDS_DTL.FieldByName('COST_WHS2').Value :=
               TGDS_DTL.FieldByName('COST_PURCH').Value + TGDS_DTL.FieldByName('COST_PURCH').Value * whsp2 / 100;
         if (TGDS_DTL.FieldByName('COST_WHS3').Value = 0) then
            TGDS_DTL.FieldByName('COST_WHS3').Value :=
               TGDS_DTL.FieldByName('COST_PURCH').Value + TGDS_DTL.FieldByName('COST_PURCH').Value * whsp3 / 100;
       end;

      TGDS_DTLUPLOADED.Value := 0;

      // Сбросить флаг Uploaded в подгруппе
      if DBmod.TSubgroupsWebUpdate.Locate('ID_GDS_SGRP', TGDS_DTLID_GDS_SGRP.Value, []) then
      begin
        DBmod.TSubgroupsWebUpdate.Edit;
        DBmod.TSubgroupsWebUpdateUPLOADED.Value := 0;
        DBmod.TSubgroupsWebUpdate.Post;

        // Сбросить флаг Uploaded в группе
        if DBmod.TGroupsWebUpdate.Locate('ID_GDS_GRP', DBmod.TSubgroupsWebUpdateID_GDS_GRP.Value, []) then
        begin
          DBmod.TGroupsWebUpdate.Edit;
          DBmod.TGroupsWebUpdateUPLOADED.Value := 0;
          DBmod.TGroupsWebUpdate.Post;
        end;

      end;
      //TGDS_SGRP.Edit;
      //TGDS_SGRPUPLOADED.Value := 0;
      //TGDS_SGRP.Post;
   end;
end;

procedure TDBmod.TGDS_GRPBeforePost(DataSet: TDataSet);
begin
	if Database1.InTransaction = false then
   	Database1.StartTransaction;

   if ggrp_ins=true then
   	TGDS_GRP.FieldByName('DEL').Value := 0;

   // Если в текущий момент не выполняется обновление сайта,
   // то это режим редактирования записей и флаг Uploaded сбрабсывается
   if g_uploading = false then
   begin
	   TGDS_GRP.FieldByName('Uploaded').Value := 0;
   end;
end;

procedure TDBmod.TGDS_DTLAfterInsert(DataSet: TDataSet);
begin
   MainForm.StatusBar1.Panels[0].Text := 'Всего записей: '+ IntToStr(DBmod.TGDS_DTL.RecordCount);
end;

procedure TDBmod.TGDS_DTLAfterDelete(DataSet: TDataSet);
begin
   MainForm.StatusBar1.Panels[0].Text := 'Всего записей: '+ IntToStr(DBmod.TGDS_DTL.RecordCount);
end;

procedure TDBmod.TCSTAfterPost(DataSet: TDataSet);
begin
   NaklForm.Refresh_CSTTable();
   NaklForm.SetIndicator(false);
end;

procedure TDBmod.TCSTBeforeInsert(DataSet: TDataSet);
begin
   NaklForm.SetIndicator(true);
end;

procedure TDBmod.TSLS_GRPAfterPost(DataSet: TDataSet);
begin
   NaklForm.Refresh_SLSTable();
end;

procedure TDBmod.TCSTAfterCancel(DataSet: TDataSet);
begin
   NaklForm.SetIndicator(false);
end;

procedure TDBmod.TSLS_GRPBeforePost(DataSet: TDataSet);
begin
   TSLS_GRP.FieldByName('ID_CST').Value := TCST.FieldByName('ID_CST').Value;
end;

procedure TDBmod.frReport1UserFunction(const Name: String; p1, p2,
  p3: Variant; var Val: Variant);
var
   i: integer;
   sum: real;
   result: string;
begin
   sum := 0;
   if AnsiCompareText('Пропись', Name) = 0 then
   begin
      QNakl.First;
      For i:= 1 to QNakl.RecordCount do
      begin
         if (extra_mode=true) then
            sum := sum +
               (QNakl.FieldByName('GDS_COST_CLR').Value*  {без НДС}
                QNakl.FieldByName('GDS_NUMB').Value) +
               ((TINF.FieldByName('NDS').Value*       {НДС}
                QNakl.FieldByName('GDS_COST_CLR').Value*
                QNakl.FieldByName('GDS_NUMB').Value)/100)
         else
            sum := sum +
               (QNakl.FieldByName('GDS_COST_NDS').Value*  {без НДС}
                QNakl.FieldByName('GDS_NUMB').Value);
         QNakl.Next
      end;
      Val := Sp3.GetRealSumma(sum,false);
   end
   else if AnsiCompareText('ЧислоПропись', Name) = 0 then
   begin
      i := QNakl.RecordCount;
      Val := Sp3.GetRealSumma(i,true);
   end
   else if AnsiCompareText('КартинкаВысота', Name) = 0 then
   begin
      Val := DefineImageHeight();
   end
   else if AnsiCompareText('Опт1', Name) = 0 then
   begin
      // определение величины накрутки для цены Опт1
      if (TDiscounts.Locate('ID_COST_DCT',1,[])) then
      begin
        result := Format('%m', [TDiscounts.FieldByName('START_SUMM').AsFloat]);
        result := Copy(result, 1, LastDelimiter(' ', result) - 1) + ' руб.';
        Val := result;
      end
      else
        Val := '30 тыс. руб';
   end
   else if AnsiCompareText('Опт2', Name) = 0 then
   begin
      // определение величины накрутки для цены Опт2
      if (TDiscounts.Locate('ID_COST_DCT',2,[])) then
      begin
        result := Format('%m', [TDiscounts.FieldByName('START_SUMM').AsFloat]);
        result := Copy(result, 1, LastDelimiter(' ', result) - 1) + ' руб.';
        Val := result;
      end
      else
        Val := '50 тыс. руб.';
   end
   else if AnsiCompareText('Опт3', Name) = 0 then
   begin
      // определение величины накрутки для цены Опт3
      if (TDiscounts.Locate('ID_COST_DCT',3,[])) then
      begin
        result := Format('%m', [TDiscounts.FieldByName('START_SUMM').AsFloat]);
        result := Copy(result, 1, LastDelimiter(' ', result) - 1) + ' руб.';
        Val := result;
      end
      else
        Val := '100 тыс. руб.';
   end
end;

function TDBmod.DefineImageHeight(): integer;
//var
   //blobStream: TBlobStream;
   //ms: TMemoryStream;
   //image: TBitmap;
begin

   if QPriceIMAGE.BlobSize <= 0 then
   begin
      Result := 0;
      exit;
   end;

   // возвращается стандратный размер (экономия накладных расходов)
   Result := 70;

   // при необходимости раскомментируйте
   {
   blobStream :=
      QPrice.CreateBlobStream(
         QPrice.FieldByName('IMAGE'), bmRead) as TBlobStream;

   try
      blobStream.Seek(0, soFromBeginning);
      ms := TMemoryStream.Create();
      try
         ms.CopyFrom(blobStream, blobStream.Size);
         image := TBitmap.Create;
         ms.Seek(0, soFromBeginning);
         image.LoadFromStream(ms);
         Result := image.Height;
      finally
         ms.Free
      end;
   finally
      blobStream.Free
   end;
   }
end;

procedure TDBmod.TGDS_DTLBeforeInsert(DataSet: TDataSet);
begin
   gdtl_ins := true;
end;

procedure TDBmod.TGDS_DTLBeforeEdit(DataSet: TDataSet);
begin
   gdtl_ins := false;
end;

procedure TDBmod.TGDS_GRPBeforeInsert(DataSet: TDataSet);
begin
   ggrp_ins := true;
end;

procedure TDBmod.TGDS_GRPBeforeEdit(DataSet: TDataSet);
begin
   ggrp_ins := false;
end;

procedure TDBmod.TGDS_DTLAfterPost(DataSet: TDataSet);
begin
	if (g_uploading = false) and (Database1.InTransaction = true) then
   	Database1.Commit;
end;

procedure TDBmod.TGDS_DTLBeforeDelete(DataSet: TDataSet);
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

procedure TDBmod.TGDS_GRPAfterPost(DataSet: TDataSet);
begin
	if (g_uploading = false) and (Database1.InTransaction = true) then
	   Database1.Commit;
end;

procedure TDBmod.TSLS_DTLBeforePost(DataSet: TDataSet);
var
  str_num: Integer;
begin
  // Если накладная без привязки к складу, то прекратить дальнейшую обработку
  if TSLS_GRP.FieldByName('STORE_CHECK').Value = 0 then
    exit;

  // Если производится списание по накладной, отключить проверку наличия товара на складе
  if DBmod.store_transfer = true then
    exit;

  // Обработка накладной с привязкой к складу
  if (TSTR.Locate('ID_GDS_DTL', TSLS_DTL.FieldByName('ID_GDS_DTL').Value,[])) then
  begin
    // на складе имеется товар
    str_num := TSTR.FieldByName('NUM').Value;

    if ((str_num = 0) AND (TSLS_DTL.FieldByName('GDS_NUMB').Value > 0)) then
    begin
      TSLS_DTL.FieldByName('GDS_NUMB').Value := 0;
      MessageDlg('На складе нет необходимого количества товара по данной позиции.',
        mtInformation, [mbOk], 0);
    end;

    if (str_num < TSLS_DTL.FieldByName('GDS_NUMB').Value) then
    begin
      TSLS_DTL.FieldByName('GDS_NUMB').Value := str_num;
      MessageDlg('На складе нет необходимого количества товара по данной позиции. Количество будет скорректированно до значения имеющегося на складе.',
        mtInformation, [mbOk], 0);
    end;
  end
  else begin
    // на складе отсутствует товар
    TSLS_DTL.FieldByName('GDS_NUMB').Value := 0;
      MessageDlg('На складе нет необходимого количества товара по данной позиции.',
        mtInformation, [mbOk], 0);
  end;
end;

procedure TDBmod.SklafGroupUpdate();
begin
   if (TSKD_GRP.RecordCount=0) then exit;
   TSKD_GRP.Edit;
   TSKD_GRP.FieldByName('SDATE').AsString := DateToStr(Date);
   TSKD_GRP.Post;
end;

procedure TDBmod.TSKD_DTLAfterInsert(DataSet: TDataSet);
begin
   SklafGroupUpdate();
end;

procedure TDBmod.TSKD_DTLAfterPost(DataSet: TDataSet);
begin
   SklafGroupUpdate();
end;

procedure TDBmod.TSKD_DTLAfterEdit(DataSet: TDataSet);
begin
   SklafGroupUpdate();
end;

procedure TDBmod.TSKD_DTLAfterDelete(DataSet: TDataSet);
begin
   SklafGroupUpdate();
end;

function TDBmod.FloatToPKOrder(sum: real): string;
var s,srub,scop: String;
    ch: char;
    i: integer;
begin
   ch := (FloatToStr(1/10))[2];
   s := FormatFloat('#,##0.00',sum);
   i := Pos(ch,s);
   srub := Copy(s,1,i-1);
   scop := Copy(s,i+1,Length(s));
   Result := srub + ' руб. ' + scop + ' коп.';
end;

procedure TDBmod.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
   all_sum, nds_sum: real;
   i: integer;
begin
   all_sum := 0;
   nds_sum := 0;
   if AnsiCompareText('SMM', ParName) = 0 then
   begin
      if (QNakl.Active=false) then begin
         QNakl.Close();
         QNakl.ParamByName('C').Value := TCST.FieldByName('ID_CST').Value;
         QNakl.ParamByName('O').Value := TSLS_GRPID_SAL_GRP.Value;
         QNakl.Open();
      end;
      QNakl.First;
      If extra_mode Then
      Begin
         For i:= 1 to QNakl.RecordCount do
         begin
            all_sum := all_sum +
                  (QNakl.FieldByName('GDS_COST_CLR').Value*  {без НДС}
                   QNakl.FieldByName('GDS_NUMB').Value) +
                  ((TINF.FieldByName('NDS').Value*       {НДС}
                   QNakl.FieldByName('GDS_COST_CLR').Value*
                   QNakl.FieldByName('GDS_NUMB').Value)/100);
            QNakl.Next
         end;
      End
      Else Begin
         For i:= 1 to QNakl.RecordCount do
         begin
            all_sum := all_sum +
                  (QNakl.FieldByName('GDS_COST_CLR').Value*  {без НДС}
                   QNakl.FieldByName('GDS_NUMB').Value);
            QNakl.Next
         end;
      End;
      ParValue := FloatToPKOrder(all_sum);
   end;
   if AnsiCompareText('NDS', ParName) = 0 then
   begin
      if (QNakl.Active=false) then begin
         QNakl.Close();
         QNakl.ParamByName('C').Value := TCST.FieldByName('ID_CST').Value;
         QNakl.ParamByName('O').Value := TSLS_GRPID_SAL_GRP.Value;
         QNakl.Open();
      end;
      QNakl.First;
      For i:= 1 to QNakl.RecordCount do
      begin
         nds_sum := nds_sum +
               ((TINF.FieldByName('NDS').Value*       {НДС}
                QNakl.FieldByName('GDS_COST_CLR').Value*
                QNakl.FieldByName('GDS_NUMB').Value)/100);
         QNakl.Next
      end;
      ParValue := FloatToPKOrder(nds_sum);
   end;
end;

procedure TDBmod.TGDS_DTLCalcFields(DataSet: TDataSet);
begin
   if TGDS_DTLIMAGE.BlobSize > 0 then
      TGDS_DTLImageType.AsInteger := 0
   else
      TGDS_DTLImageType.AsInteger := -1;

   if (TGDS_DTLUPLOADED <> nil) AND (TGDS_DTLUPLOADED.AsInteger = 1) then
      TGDS_DTLWeb.AsInteger := 1
   else
      TGDS_DTLWeb.AsInteger := -1;
end;

procedure TDBmod.XLSExportPriceDataSourceSaveTitle(FieldIndex: Integer;
  XLSCell: TCell);
var
    Column: TColumn;
begin
        XLSCell.FontBold := True;

        { Set cell fill pattern and color }
        XLSCell.FillPattern:= xlPatternSolid;
        XLSCell.FillPatternBGColorIndex:= TXLColorIndex(23);
        { Set font color }
        XLSCell.FontColorIndex:= TXLColorIndex(2);

        Column := ExportPriceExcelFile.Workbook.Sheets[0].Columns[FieldIndex];
        Column.HAlign:= xlHAlignLeft;

        if (XLSCell.Col = 0) then XLSCell.Value := 'Код';
        if (XLSCell.Col = 1) then XLSCell.Value := 'Группа товаров';
        if (XLSCell.Col = 2) then XLSCell.Value := 'Наименование';
        if (XLSCell.Col = 3) then XLSCell.Value := 'Упаковка';
        if (XLSCell.Col = 4) then begin
            XLSCell.Value:= 'Опт1 цена';
            Column.HAlign:= xlHAlignCenter;
            Column.WidthPx:= 150;
        end;
        if (XLSCell.Col = 5) then begin
            XLSCell.Value := 'Опт2 цена';
            Column.HAlign:= xlHAlignCenter;
            Column.WidthPx:= 150;
        end;
        if (XLSCell.Col = 6) then begin
            XLSCell.Value := 'Опт3 цена';
            Column.HAlign:= xlHAlignCenter;
            Column.WidthPx:= 150;
        end;
end;

procedure TDBmod.XLSExportNakladnayaDataSourceSaveTitle(
  FieldIndex: Integer; XLSCell: TCell);
var
    Column: TColumn;
begin
        XLSCell.FontBold := True;

        { Set cell fill pattern and color }
        XLSCell.FillPattern:= xlPatternSolid;
        XLSCell.FillPatternBGColorIndex:= TXLColorIndex(23);
        { Set font color }
        XLSCell.FontColorIndex:= TXLColorIndex(2);

        Column := ExportNakladnayaExcelFile.Workbook.Sheets[0].Columns[FieldIndex];
        Column.HAlign:= xlHAlignLeft;

        if (XLSCell.Col = 0) then XLSCell.Value := 'Код';
        if (XLSCell.Col = 1) then XLSCell.Value := 'Наименование';
        if (XLSCell.Col = 2) then XLSCell.Value := 'Цена, руб.';
        if (XLSCell.Col = 3) then XLSCell.Value := 'Количество';
        if (XLSCell.Col = 4) then XLSCell.Value := 'Дата';
end;


procedure TDBmod.TGDS_SGRPBeforeEdit(DataSet: TDataSet);
begin
   gsgrp_ins := false;
end;

procedure TDBmod.TGDS_SGRPBeforeInsert(DataSet: TDataSet);
begin
   gsgrp_ins := true;
end;

procedure TDBmod.TGDS_SGRPBeforePost(DataSet: TDataSet);
begin
	if Database1.InTransaction = false then
   	Database1.StartTransaction;

   if gsgrp_ins=true then
   begin
   	TGDS_SGRP.FieldByName('ID_GDS_GRP').Value := TGDS_GRP.FieldByName('ID_GDS_GRP').Value;
      TGDS_SGRP.FieldByName('DEL').Value := 0;
   end;

   // Если в текущий момент не выполняется обновление сайта,
   // то это режим редактирования записей и флаг Uploaded сбрабсывается
   if g_uploading = false then
   begin
	   TGDS_SGRP.FieldByName('Uploaded').Value := 0;

     // В группе, в которую входит подгруппа необходимо сбросить флаг Uploaded
	   TGDS_GRP.Edit;
	   TGDS_GRP.FieldByName('Uploaded').Value := 0;
	   TGDS_GRP.Post;
   end;
end;

procedure TDBmod.TGDS_SGRPAfterPost(DataSet: TDataSet);
begin
	if (g_uploading = false) and (Database1.InTransaction = true) then
   	Database1.Commit;
end;

procedure TDBmod.TDiscountsBeforePost(DataSet: TDataSet);
begin
   // Если в текущий момент не выполняется обновление сайта,
   // то это режим редактирования записей и флаг Uploaded сбрабсывается
   if g_uploading = false then
      TDiscountsUPLOADED.Value := 0;
end;

end.
