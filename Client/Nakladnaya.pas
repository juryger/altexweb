unit Nakladnaya;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGridEh, Mask, DBCtrlsEh, Buttons, DB,
  DBLookupEh, DBCtrls, XLSFile, XLSWorkbook, Variants, XMLDoc, XMLIntf, StrUtils,
  AppSettingsHelper, Sum_Propis_3;

type
  TNaklForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    Panel5: TPanel;
    DBGridEh3: TDBGridEh;
    clientsManagementPanel: TPanel;
    applyCustomerChangesButton: TSpeedButton;
    deleteCustomerButton: TSpeedButton;
    importWebOrderButton: TSpeedButton;
    importOrdersDialog: TOpenDialog;
    Panel6: TPanel;
    previewButton: TSpeedButton;
    printButton: TSpeedButton;
    deleteGoodsItemButton: TSpeedButton;
    addCustomerButton: TSpeedButton;
    invoiceManagementPanel: TPanel;
    newOrderButton: TSpeedButton;
    deleteOrderButton: TSpeedButton;
    Label3: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    orderNoComboBox: TDBLookupComboboxEh;
    saleDateTextBox: TEdit;
    webOrderNoTextBox: TEdit;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Label7: TLabel;
    Label4: TLabel;
    DBEditEh1: TDBEditEh;
    btExportAccountExcel: TSpeedButton;
    profitCalcButton: TSpeedButton;
    applyCashlessButton: TSpeedButton;
    resetClientSearchButton: TSpeedButton;
    Panel4: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    resetSearchButton: TSpeedButton;
    DBEditEh2: TDBEditEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure deleteCustomerButtonClick(Sender: TObject);
    procedure deleteOrderButtonClick(Sender: TObject);
    procedure deleteGoodsItemButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridEh1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGridEh3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure applyCustomerChangesButtonClick(Sender: TObject);
    procedure newOrderButtonClick(Sender: TObject);
    procedure printButtonClick(Sender: TObject);
    procedure previewButtonClick(Sender: TObject);
    procedure orderNoComboBoxKeyValueChanged(Sender: TObject);
    procedure DBEditEh2Click(Sender: TObject);
    procedure DBEditEh2Change(Sender: TObject);
    procedure importWebOrderButtonClick(Sender: TObject);
    procedure DBEditEh1Click(Sender: TObject);
    procedure DBEditEh1Change(Sender: TObject);
    procedure addCustomerButtonClick(Sender: TObject);
    procedure DBEditEh1KeyPress(Sender: TObject; var Key: Char);
    procedure btExportAccountExcelClick(Sender: TObject);
    procedure profitCalcButtonClick(Sender: TObject);
    procedure applyCashlessButtonClick(Sender: TObject);
    procedure resetSearchButtonClick(Sender: TObject);
    procedure resetClientSearchButtonClick(Sender: TObject);
  private
    { Private declarations }
    function ImportCustomerFromWebOrder(customer: IXMLNode): Boolean;
    function ImportOrderDetailsFromWebOrder(webOrderId: integer; created: TDateTime; details: IXMLNode): Boolean;
    function GetNextOrderId(): integer;
    procedure ExportBillToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime);
    procedure ExportDeliveryNoteToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime; orderNo: integer);
    procedure ExportInvoiceToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime; orderNo: integer);
    function CalculateSumWithoutTax(sum: Double; taxValue: integer): Double;
    function CalculateTax(sum: Double; taxValue: integer): Double;
  public
    { Public declarations }
    procedure Refresh_CSTTable();
    procedure Refresh_SLSTable();
    procedure SetIndicator(val: boolean);
    function GetMonth(): Integer;
    procedure Replay();
  end;

const
   customerInfoArray : Array [ 0..6 ] of String = ( 'id', 'company', 'phone', 'email', 'contactName', 'address', 'inn' );
   
var
  NaklForm: TNaklForm;

implementation

uses dbModule, MAIN, Price, DatePickUp, NDS_Params, ShellAPI, XLSFormat, FILECTRL, AccountParams;

{$R *.DFM}

procedure TNaklForm.SetIndicator(val: boolean);
begin
   applyCustomerChangesButton.Enabled := val;
end;

procedure TNaklForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   MainForm.IsNaklClosed := true;
   MainForm.StatusBar1.Panels[0].Text := '';

   // сбросить флаги
   DBmod.store_transfer := false;
   DBmod.extra_mode := false;
end;

procedure TNaklForm.Refresh_CSTTable();
var
   fs: String;
begin
   if DBmod.TCST.RecordCount=0 then
      exit;

   fs := DBmod.TCST.FieldByName('ID_CST').AsString;
   if fs='' then
      fs := '-1';

   DBmod.TSLS_GRP.Filtered := false;
   DBmod.TSLS_GRP.Filter := 'ID_CST='+fs;
   DBmod.TSLS_GRP.Filtered := true;

   if (DBmod.TSLS_GRP.RecordCount > 0) then
   begin
      DBmod.TSLS_GRP.Last;
      orderNoComboBox.Text := DBmod.TSLS_GRPOrderNo.AsString;
      saleDateTextBox.Text := DBmod.TSLS_GRPSDATE.AsString;
      webOrderNoTextBox.Text := DBMod.TSLS_GRPID_WEB.AsString;
   end
   else
      orderNoComboBox.KeyValue := null;
end;

procedure TNaklForm.Refresh_SLSTable();
var
   fs: String;
begin
   if DBmod.TSLS_GRP.RecordCount > 0 then
   begin
      saleDateTextBox.Text := DBmod.TSLS_GRPSDATE.AsString;
      webOrderNoTextBox.Text := DBMod.TSLS_GRPID_WEB.AsString;

      if (DBMod.TSLS_GRPCashlessPayment.Value = 0) then
        applyCashlessButton.Visible := true
      else
        applyCashlessButton.Visible := false;
   end
   else begin
      saleDateTextBox.Text := '';
      webOrderNoTextBox.Text  := '';
   end;

   fs := DBmod.TSLS_GRP.FieldByName('ID_SAL_GRP').AsString;
   if fs='' then
      fs := '-1';

   DBmod.TSLS_DTL.Filtered := false;
   DBmod.TSLS_DTL.Filter := 'ID_SLE_GRP='+fs;
   DBmod.TSLS_DTL.Filtered := true;

   // Если накладная уже была расчитана, то запретить менять количество
   // (только для накладных привязанных к складу)
   if ((DBmod.TSLS_GRP.FieldByName('STORE_CHECK').Value = 1) AND (DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsFloat > 0)) then
   begin
      DBGridEh3.Columns[2].ReadOnly := true;
      DBGridEh3.Columns[2].Color := clInactiveBorder;

      DBGridEh3.Columns[3].ReadOnly := true;
      DBGridEh3.Columns[3].Color := clInactiveBorder;
   end
   else begin
      DBGridEh3.Columns[2].ReadOnly := false;
      DBGridEh3.Columns[2].Color := clWindow;

      DBGridEh3.Columns[3].ReadOnly := false;
      DBGridEh3.Columns[3].Color := clWindow;
   end;
end;

procedure TNaklForm.deleteCustomerButtonClick(Sender: TObject);
var
   i: integer;
begin
   if (DBmod.TCST.RecordCount=0) then exit;
   if MessageDlg('Хотите удалить клиента <'+ DBmod.TCST.FieldByName('Company').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
   if (DBmod.TSLS_GRP.RecordCount<>0) then begin
      for i:=1 to DBmod.TSLS_DTL.RecordCount do DBmod.TSLS_DTL.Delete;
      for i:=1 to DBmod.TSLS_GRP.RecordCount do DBmod.TSLS_GRP.Delete;
   end;
   DBmod.TCST.Delete;
   Refresh_CSTTable();
end;

procedure TNaklForm.deleteOrderButtonClick(Sender: TObject);
var
   i: integer;
begin
   if (DBmod.TSLS_GRP.RecordCount=0) then exit;
   if MessageDlg('Хотите удалить продажу от <'+ DBmod.TSLS_GRP.FieldByName('SDATE').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
   if (DBmod.TSLS_DTL.RecordCount<>0) then begin
      for i:=1 to DBmod.TSLS_DTL.RecordCount do DBmod.TSLS_DTL.Delete;
   end;
   DBmod.TSLS_GRP.Delete;
   Refresh_CSTTable();
end;

procedure TNaklForm.deleteGoodsItemButtonClick(Sender: TObject);
begin
   if (DBmod.TSLS_DTL.RecordCount=0) then exit;
   if MessageDlg('Хотите удалить позицию <'+ DBmod.TSLS_DTL.FieldByName('Title').AsString+'> ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
   DBmod.TSLS_DTL.Delete;
end;

procedure TNaklForm.FormShow(Sender: TObject);
begin
   Refresh_CSTTable();
   DBGridEh1.SetFocus;
end;

procedure TNaklForm.DBGridEh1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Refresh_CSTTable();
end;

procedure TNaklForm.DBGridEh1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Refresh_CSTTable();
end;

procedure TNaklForm.DBGridEh1CellClick(Column: TColumnEh);
begin
   Refresh_CSTTable();
end;

procedure TNaklForm.DBGridEh3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   if (PriceForm.priceDragObj) then Accept := true
   else Accept := false;
end;

procedure TNaklForm.DBGridEh3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
    cost: Real;
   dtl_i: Integer;
   whs_column: String;
begin
  if DBMod.TCST.RecordCount = 0 then exit;
  if (Sender is TDBGridEh) and (PriceForm.priceDragObj) then
  begin
    with Sender as TDBGridEh do
    begin
      dtl_i     := DBmod.TGDS_DTL.FieldByName('ID_GDS_DTL').Value;

      // NOTE: определить стоимость товара в зависимости от настроек скидок для клиента
      whs_column := 'COST_WHS' + DBMod.TCSTID_COST_DCT.AsString;
      cost := DBmod.TGDS_DTL.FieldByName(whs_column).Value;

      // Добавить запись loPartialKey,loCaseInsensitive
      if DBmod.TSLS_DTL.Locate('ID_GDS_DTL',dtl_i,[]) then
        DBmod.TSLS_DTL.Edit()
      else
        DBmod.TSLS_DTL.Insert();

      DBmod.TSLS_DTL.FieldByName('ID_GDS_DTL').Value   := dtl_i;
      DBmod.TSLS_DTL.FieldByName('ID_SLE_GRP').Value   := DBmod.TSLS_GRP.FieldByName('ID_SAL_GRP').Value;
      DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').Value := cost;
      DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').Value := 0;
      DBmod.TSLS_DTL.FieldByName('GDS_NUMB').Value     := 0;
      DBmod.TSLS_DTL.Post;
    end;
  end;
end;

procedure TNaklForm.applyCustomerChangesButtonClick(Sender: TObject);
begin
   DBmod.TCST.Post;
end;

procedure TNaklForm.newOrderButtonClick(Sender: TObject);
var
  useStore: integer;
begin
   if (DPickUpForm.ShowModal=mrOk) then
   begin
      useStore := 0;
      if DPickUpForm.UseStoreCheckBox.Checked then
        useStore := 1;

      // Проверить заполненность собственных реквизитов
      if (DBMod.TINF.RecordCount = 0) then begin
         MessageDlg('Раздел Реквизиты не заполнен. Заполните реквизиты компании.',
            mtInformation, [mbOk], 0);
         exit;
      end;

      DBMod.TSLS_GRP.Insert;
      DBMod.TSLS_GRPSDATE.Value := DPickUpForm.MonthCalendar1.Date;
      DBMod.TSLS_GRPSTORE_CHECK.Value := useStore;
      DBMod.TSLS_GRPOrderNo.Value := GetNextOrderId();
      DBMod.TSLS_GRP.Post;

      orderNoComboBox.Text := DBMod.TSLS_GRPOrderNo.AsString;
      saleDateTextBox.Text := DBMod.TSLS_GRPSDATE.AsString;
      webOrderNoTextBox.Text := DBMod.TSLS_GRPID_WEB.AsString;

      // По заявкам трудящихся убираем перенос товара из предыдущей накладной
      //Replay();
   end;
end;

function TNaklForm.GetMonth(): Integer;
var d,m: String;
begin
   d:= DateTimeToStr(Date());
   Delete(d,1,Pos('.',d));
   m:= Copy(d,1,2);
   Result:= StrToInt(m);
end;

procedure TNaklForm.Replay();
var
   o_rn, i, o_i, dtl_i: integer;
   desc: String;
   c_opt: real;
begin
   if DbMod.TSLS_GRP.RecordCount < 2 then exit;
   o_rn := DbMod.TSLS_GRP.RecNo;
   o_i := DbMod.TSLS_GRP.FieldByName('ID_SAL_GRP').Value;
   DbMod.TSLS_GRP.Prior;
   Refresh_SLSTable();
   for i:=1 to DbMod.TSLS_DTL.RecordCount do begin
      dtl_i := DBmod.TSLS_DTL.FieldByName('ID_GDS_DTL').Value;
      desc  := DBmod.TSLS_DTL.FieldByName('GDS_DESCR').AsString;
      c_opt := DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').Value;
      DbMod.TSLS_DTL.Insert;
      DBmod.TSLS_DTL.FieldByName('ID_GDS_DTL').Value   := dtl_i;
      DBmod.TSLS_DTL.FieldByName('ID_SLE_GRP').Value   := o_i;
      DBmod.TSLS_DTL.FieldByName('GDS_DESCR').AsString := desc;
      DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').Value := c_opt;
      DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').Value := 0;
      DBmod.TSLS_DTL.FieldByName('GDS_NUMB').Value     := 0;
      DbMod.TSLS_DTL.Post;
   end;
   DbMod.TSLS_GRP.RecNo := o_rn;
   Refresh_SLSTable();
end;

procedure TNaklForm.printButtonClick(Sender: TObject);
var i: integer;
    gds_id: integer;
    gds_num: integer;
begin
   if (DBMod.TSLS_DTL.RecordCount = 0) then
      exit;

   // Проверить заполненность собственных реквизитов
   if (DBMod.TINF.RecordCount = 0) then begin
      MessageDlg('Раздел Реквизиты не заполнен. Заполните реквизиты компании.',
        mtInformation, [mbOk], 0);
      exit;
   end;

   // Выбрать вариант накладной
   if (NdsParamsForm.ShowModal()=mrCancel) then
      exit;

   if (NdsParamsForm.ndsViewRadioButton.Checked = true) then
      DBmod.extra_mode := true
   else
      DBmod.extra_mode := false;

   // установить флаг списания товара (чтобы отключить проверку на наличие необходимого количества на складе)
   DBmod.store_transfer := true;

   // Пересчитать сумму с учетом НДС (+Обновление количества на складе)
   DBmod.TSLS_DTL.First;
   for i:=1 to DBmod.TSLS_DTL.RecordCount do
   begin
        // если используется накладная с привязкой к складу, то выполнить списание
        if DBmod.TSLS_GRP.FieldByName('STORE_CHECK').Value = 1 then
        begin
          // если позиция уже расчитана, то не производить списание со склада (списание уже проведено)
          if (DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsFloat = 0) then
          begin
            gds_id := DBmod.TSLS_DTL.FieldByName('ID_GDS_DTL').Value;
            gds_num := DBmod.TSLS_DTL.FieldByName('GDS_NUMB').Value;

            // уменьшить количество товара на складе
            if (DBmod.TSTR.Locate('ID_GDS_DTL', gds_id,[])) then
            begin
              if (DBmod.TSTR.FieldByName('NUM').Value <= gds_num) then
	              	DBmod.TSTR.Delete
              else
              begin
              	 DBmod.TSTR.Edit;
                DBmod.TSTR.FieldByName('NUM').Value :=
                 	DBmod.TSTR.FieldByName('NUM').Value - gds_num;
              	 DBmod.TSTR.Post;
              end;
            end;
          end;
        end;

        // Расчет цены без НДС по текущей позиции
        DBmod.TSLS_DTL.Edit;
        if DBmod.extra_mode then
            DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsString :=
                FormatFloat('#,##.00',(DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').AsFloat * 100) / (100 + DBMod.TINF.FieldByName('NDS').AsFloat))
        else
            DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsFloat :=
                DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').AsFloat;
        DBmod.TSLS_DTL.Post;
        DBmod.TSLS_DTL.Next;
   end;

   // сбросить флаг списания товара
   DBmod.store_transfer := false;

   // Подготовить данные по заказу
   DBmod.QNakl.Close();
   DBmod.QNakl.ParamByName('C').Value := DBmod.TCST.FieldByName('ID_CST').Value;
   DBmod.QNakl.ParamByName('O').Value := DBmod.TSLS_GRPID_SAL_GRP.Value;
   DBmod.QNakl.Open();

   DBmod.frReport1.Dataset := DBmod.frNakl;

   // Подгрузить соответствующий отчет
   if (NdsParamsForm.simpleViewRadioButton.Checked=true) then
      DBmod.frReport1.LoadFromFile('..\reports\nakladnaya_light.frf')
   else if (NdsParamsForm.noNdsViewRadioButton.Checked = true) then
      DBmod.frReport1.LoadFromFile('..\reports\nakladnaya_no_nds.frf')
   else if (NdsParamsForm.ndsViewRadioButton.Checked = true) then
      DBmod.frReport1.LoadFromFile('..\reports\nakladnaya_nds.frf');

   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.PrintPreparedReportDlg;

   if NdsParamsForm.simpleViewRadioButton.Checked = false then
   begin
      // Счет-фактура
      if (NdsParamsForm.InvoiceCheckBox.Checked = true) then
      begin
         DBmod.frReport1.Dataset := DBmod.frInvoice;

         if (NdsParamsForm.ndsViewRadioButton.Checked = true) then
            DBmod.frReport1.LoadFromFile('..\reports\Invoice_nds.frf')
         else if (NdsParamsForm.noNdsViewRadioButton.Checked = true) then
            DBmod.frReport1.LoadFromFile('..\reports\Invoice_no_nds.frf');

         DBmod.frReport1.PrepareReport;
         DBmod.frReport1.PrintPreparedReportDlg;
      end;

      // Приходный кассовый ордер
      if (NdsParamsForm.TicketCheckBox.Checked = true) then
      begin
         DBmod.frReport1.Dataset := DBmod.frNakl;

         if (NdsParamsForm.ndsViewRadioButton.Checked = true) then
            DBmod.frReport1.LoadFromFile('ticket_nds.frf')
         else if (NdsParamsForm.noNdsViewRadioButton.Checked = true) then
            DBmod.frReport1.LoadFromFile('..\reports\ticket_no_nds.frf');

         DBmod.frReport1.PrepareReport;
         DBmod.frReport1.PrintPreparedReportDlg;
      end;
   end;

   DBmod.TSTR.FlushBuffers;
   DBmod.TSLS_DTL.FlushBuffers;
   DBmod.TINF.FlushBuffers;

   Refresh_SLSTable();
end;

procedure TNaklForm.previewButtonClick(Sender: TObject);
begin
   DBmod.QNakl.Close();
   DBmod.QNakl.ParamByName('C').Value := DBmod.TCST.FieldByName('ID_CST').Value;
   DBmod.QNakl.ParamByName('O').Value := DBmod.TSLS_GRPID_SAL_GRP.Value;
   DBmod.QNakl.Open();

   DBmod.frReport1.Dataset := DBmod.frInvoice;
   DBmod.frReport1.LoadFromFile('Invoice_no_nds.frf');

   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.ShowReport;

   DBmod.frReport1.Dataset := DBmod.frNakl;
   DBmod.frReport1.LoadFromFile('..\reports\nakladnaya_no_nds.frf');

   DBmod.frReport1.PrepareReport;
   DBmod.frReport1.ShowReport;
end;

procedure TNaklForm.orderNoComboBoxKeyValueChanged(Sender: TObject);
begin
   Refresh_SLSTable();
end;

procedure TNaklForm.DBEditEh2Click(Sender: TObject);
begin
	DBEditEh2.SelectAll;
end;

procedure TNaklForm.DBEditEh2Change(Sender: TObject);
begin
   If DBEditEh2.Text='' then
   	DBmod.TSLS_DTL.First
   else
   	DBmod.TSLS_DTL.Locate('ID_GDS_DTL',DBEditEh2.Text,[loPartialKey,loCaseInsensitive])
end;

procedure TNaklForm.importWebOrderButtonClick(Sender: TObject);
var
   i, j: integer;
   webOrderId: string;
   orderCreated: string;
   fileName: string;
   xml: IXMLDocument;
   testItem, orderItem: IXMLNode;
   decimalChar: char;
begin
   if importOrdersDialog.Execute() = false then
      exit;

   decimalChar := DecimalSeparator;
   try
      DecimalSeparator := '.';
   //-----------Try---------
   for i := 0 to importOrdersDialog.Files.Count - 1 do
   begin
      fileName := importOrdersDialog.Files[i];
      xml := LoadXMLDocument(fileName);

      // Импорт заказа
      orderItem := xml.DocumentElement;
      webOrderId := orderItem.GetAttributeNS('id', '');
      orderCreated := orderItem.GetAttributeNS('created', '');

      for j := 0 to orderItem.ChildNodes.Count - 1 do
      begin
         testItem := orderItem.ChildNodes[j];
         if testItem.LocalName = 'Customer' then
         begin
            // Импорт клиента
            if not ImportCustomerFromWebOrder(testItem) then
               continue;
         end
         else if (testItem.LocalName = 'Details') then
         begin
            // Импорт товаров в заказ
            if not ImportOrderDetailsFromWebOrder(StrToInt(webOrderId), StrToDate(orderCreated), testItem) then
               continue;
         end;
      end;

      Refresh_CSTTable();
   end;
   //----------EndOfTry----------
   finally
      DecimalSeparator := decimalChar;
   end;
end;

function TNaklForm.ImportCustomerFromWebOrder(customer: IXMLNode): Boolean;
var
   i: integer;
   nameAttribute: string;
   customerGuid, company, phone, email, contactName, address, inn: string;
   item: IXMLNode;
begin
    // чтение значений элементов Info из секции Customer
    for i := 0 to customer.ChildNodes.Count - 1 do
    begin
        item := customer.ChildNodes[i];
        nameAttribute := item.GetAttributeNS('name', '');

        case AnsiIndexStr(nameAttribute, customerInfoArray) of
            0: customerGuid := item.GetAttributeNS('value', '');
            1: company := item.GetAttributeNS('value', '');
            2: phone := item.GetAttributeNS('value', '');
            3: email := item.GetAttributeNS('value', '');
            4: contactName := item.GetAttributeNS('value', '');
            5: address := item.GetAttributeNS('value', '');
            6: inn := item.GetAttributeNS('value', '');
            else
                MessageDlg('В XML файле передан неподдерживаемый атрибут: Order->Customer->Info->@' + nameAttribute + '. Импорт данного заказа будет прекращен.',
                    mtInformation, [mbOK], 0);
                Result := False;
                exit;
        end;
    end;

    // Обновление БД
    if ((customerGuid <> '') AND DBmod.TCST.Locate('Guid', customerGuid, [loPartialKey,loCaseInsensitive])) then
        DBmod.TCST.Edit
    else if ((email <> '') AND DBmod.TCST.Locate('Email', email, [loPartialKey,loCaseInsensitive])) then
        DBmod.TCST.Edit
    else if ((inn <> '') AND DBmod.TCST.Locate('INN', inn, [loPartialKey,loCaseInsensitive])) then
        DBmod.TCST.Edit
    else if ((company <> '') AND DBmod.TCST.Locate('Company', company, [loPartialKey,loCaseInsensitive])) then
        DBmod.TCST.Edit
    else
        DBmod.TCST.Insert;

    if (customerGuid <> '') then
        DBmod.TCSTGuid.Value := customerGuid;

    if (email <> '') then
        DBmod.TCSTEmail.Value := email;

    if (company <> '') then
        DBmod.TCSTCompany.Value := company;

    if (inn <> '') then
        DBmod.TCSTINN.Value := inn;

    if (contactName <> '') then
        DBmod.TCSTContactName.Value := contactName;

    if (address <> '') then
        DBmod.TCSTAddress.Value := address;

    if (phone <> '') then
        DBmod.TCSTPhone.Value := phone;

    DBmod.TCST.Post;
    Result := True;
end;

function TNaklForm.GetNextOrderId(): integer;
var
   orderNo: integer;
begin
   // Получить идентификатор для нового заказа
   DBmod.TINF.RecNo := 1;
   orderNo := DBmod.TINFOrderCounter.Value;
   // Увеличить счетчик заказов
   DBmod.TINF.Edit;
   DBmod.TINFOrderCounter.Value := orderNo + 1;
   DBmod.TINF.Post;

   Result := orderNo;
end;

function TNaklForm.ImportOrderDetailsFromWebOrder(webOrderId: integer; created: TDateTime; details: IXMLNode): Boolean;
var
   i: integer;
   item: IXMLNode;
begin
   if DBmod.TSLS_GRP.Locate('ID_WEB', webOrderId, []) = True then
   begin
      MessageDlg('Заказ с номером: "' + IntToStr(webOrderId) + '" уже импортирован в БД.',
         mtInformation, [mbOK], 0);
      Result := False;
      exit;
   end;


   // Импорт заказа в БД
   DBmod.TSLS_GRP.Insert;
   DBmod.TSLS_GRPID_CST.Value := DBmod.TCSTID_CST.Value;
   Dbmod.TSLS_GRPOrderNo.Value := GetNextOrderId();
   DBmod.TSLS_GRPID_WEB.Value := webOrderId;
   DBmod.TSLS_GRPSDATE.Value := created;
   DBmod.TSLS_GRP.Post;

   // Чтение значений элементов Item из секции Details
   for i := 0 to details.ChildNodes.Count - 1 do
   begin
      item := details.ChildNodes[i];
      
      // Импорт деталей заказа в БД
      DBmod.TSLS_DTL.Insert;
      DBmod.TSLS_DTLID_SLE_GRP.Value := DBmod.TSLS_GRPID_SAL_GRP.Value;
      DBmod.TSLS_DTLID_GDS_DTL.Value := item.GetAttributeNS('merchandiseId', '');
      DBmod.TSLS_DTLGDS_NUMB.Value := StrToInt(item.GetAttributeNS('quantity', ''));
      DBmod.TSLS_DTLGDS_COST_NDS.Value := StrToFloat(item.GetAttributeNS('cost', ''));
      DBmod.TSLS_DTLComment.Value := item.GetAttributeNS('comment', '');
      DBmod.TSLS_DTL.Post;
   end;

   Result := True;
end;

procedure TNaklForm.DBEditEh1Click(Sender: TObject);
begin
	DBEditEh1.SelectAll;
end;

procedure TNaklForm.DBEditEh1Change(Sender: TObject);
var
  enterKey: Char;
begin
   If DBEditEh1.Text='' then
   begin
      DBMod.TCST.Filtered := False;
      DBmod.TCST.First;
   end
   else
   begin
      enterKey := #13;
      //DBmod.TCST.Locate('Company',DBEditEh1.Text,[loPartialKey,loCaseInsensitive]);
      DBEditEh1KeyPress(Sender, enterKey);
   end
end;

procedure TNaklForm.addCustomerButtonClick(Sender: TObject);
begin
   DBMod.TCST.Insert;
end;

procedure TNaklForm.DBEditEh1KeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  sFilter: string;
begin
  if (Key = #13) AND (Trim(DBEditEh1.Text) <> '') then
  begin
      DBMod.QCustomerLookup.Close();
      DBMod.QCustomerLookup.ParamByName('C').Value := DBEditEh1.Text;
      DBMod.QCustomerLookup.Open();
      DBMod.QCustomerLookup.First;

      sFilter := '';

      if (DBMod.QCustomerLookup.RecordCount > 0) then
      begin
        For i := 1 to DBMod.QCustomerLookup.RecordCount do
        begin
         sFilter := sFilter + 'ID_CST = ' + DBMod.QCustomerLookupID_CST.AsString + ' OR ';
         DBMod.QCustomerLookup.Next;
        end;
        sFilter := Copy(sFilter, 1, Length(sFilter)  - 4);
      end;

      DBmod.TCST.Filtered := False;
      DBmod.TCST.Filter := sFilter;
      DBmod.TCST.Filtered := True;
  end;
end;

procedure TNaklForm.btExportAccountExcelClick(Sender: TObject);
var
    excelDir, billNo: string;
    hasTax: boolean;
    i, taxValue, orderNo: integer;
    billDate: TDateTime;
begin
    if (DBMod.TSLS_DTL.RecordCount = 0) then
      exit;

    // Проверить заполненность собственных реквизитов
    if (DBMod.TINF.RecordCount = 0) then begin
      MessageDlg('Раздел Реквизиты не заполнен. Заполните реквизиты компании.',
        mtInformation, [mbOk], 0);
      exit;
    end;

    if (frmAccountParams.ShowModal() = mrCancel) then
        exit;

    hasTax := frmAccountParams.HasNDS;
    taxValue := StrToInt(frmAccountParams.tbPercentageValue.Text);
    billNo := frmAccountParams.tbAccNo.Text;
    billDate := frmAccountParams.dtpAccountDate.Date;

    // Пересчитать сумму с учетом НДС
    DBmod.TSLS_DTL.First;
    for i:=1 to DBmod.TSLS_DTL.RecordCount do
    begin
        // Расчет цены без НДС по текущей позиции
        DBmod.TSLS_DTL.Edit;
        if hasTax then
            DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsString :=
                FormatFloat('#,##.00',(DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').AsFloat * 100) / (100 + taxValue))
        else
            DBmod.TSLS_DTL.FieldByName('GDS_COST_CLR').AsFloat :=
                DBmod.TSLS_DTL.FieldByName('GDS_COST_NDS').AsFloat;
        DBmod.TSLS_DTL.Post;
        DBmod.TSLS_DTL.Next;
    end;

    excelDir := GetSettingsParam(Self, 'TempDir') + '\AG\Excel';

    orderNo := DBmod.TSLS_GRPID_WEB.Value;
    if (orderNo = 0) then
    begin
        orderNo := Dbmod.TSLS_GRPOrderNo.Value;
    end;

    ExportBillToExcel(excelDir, hasTax, taxValue, billNo, billDate);
    ExportDeliveryNoteToExcel(excelDir, hasTax, taxValue, billNo, billDate, orderNo);
    ExportInvoiceToExcel(excelDir, hasTax, taxValue, billNo, billDate, orderNo);

    DBMod.TSLS_DTL.First;

    { Procedure uses OS shell to open and view XLS file }
    ShellExecute(0, 'open', PChar(excelDir), nil, nil, SW_SHOW);
end;

procedure TNaklForm.ExportBillToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime);
var
    billTitle, fileName, customerInfo, sumItemsText, strBuff1, strBuff2, strBuff3: string;
    xf: TXLSFile;
    i, itemsCount: Integer;
    sum: Real;
begin
    xf:= TXLSFile.Create;
    try
        xf.OpenFile('..\templates\bill.xls');

        with xf.Workbook.Sheets[0] do
        begin
            { Header }
            billTitle := StringReplace(Cells.CellByA1Ref['B10'].Value, '{0}',
                billNo, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B10'].Value := StringReplace(billTitle, '{1}',
                DateToStr(billDate), [rfReplaceAll, rfIgnoreCase]);

            strBuff1 := Cells.CellByA1Ref['D5'].Value; Cells.CellByA1Ref['D5'].Clear();
            strBuff2 := Cells.CellByA1Ref['W3'].Value; Cells.CellByA1Ref['W3'].Clear();
            strBuff3 := Cells.CellByA1Ref['W5'].Value; Cells.CellByA1Ref['W5'].Clear();
            Cells.CellByA1Ref['D5'].Value := strBuff1;
            Cells.CellByA1Ref['W3'].Value := strBuff2;
            Cells.CellByA1Ref['W5'].Value := strBuff3;
            Cells.CellByA1Ref['D5'].FormatStringIndex := 1;
            Cells.CellByA1Ref['W3'].FormatStringIndex := 1;
            Cells.CellByA1Ref['W5'].FormatStringIndex := 1;

            // Customer
            customerInfo := DBMod.TCSTCompany.Value + ', ИНН: ' + DBMod.TCSTINN.Value +
                ', ' + DBMod.TCSTAddress.Value + ', тел. ' + DBMod.TCSTPhone.Value;
            Cells.CellByA1Ref['H16'].Value := customerInfo;
            Cells.CellByA1Ref['H18'].Value := customerInfo;

            { Body }
            sum :=0;
            itemsCount := DBMod.TSLS_DTL.RecordCount;
            Rows.InsertRows(20, itemsCount - 1);

            // row number - [20,1], item title - [20,2], item amount - [20,3], cost - [20,5], sum - [20,6]
            DBMod.TSLS_DTL.First;
            for i := 1 to DBMod.TSLS_DTL.RecordCount do
            begin
                if (i <> DBMod.TSLS_DTL.RecordCount) then
                begin
                    Rows.CopyRows(19 + i,19 + i, 20 + i);
                end;

                Cells.CellByA1Ref['B' + IntToStr(20 + i)].Value := i;
                Cells.CellByA1Ref['D' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLTitle.Value;
                Cells.CellByA1Ref['Y' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value;

                Cells.CellByA1Ref['AD' + IntToStr(20 + i)].Clear();
                if (hasTax) then
                  Cells.CellByA1Ref['AD' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  Cells.CellByA1Ref['AD' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['AD' + IntToStr(20 + i)].FormatStringIndex := 2;

                Cells.CellByA1Ref['AH' + IntToStr(20 + i)].Clear();
                if (hasTax) then
                  Cells.CellByA1Ref['AH' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  Cells.CellByA1Ref['AH' + IntToStr(20 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['AH' + IntToStr(20 + i)].FormatStringIndex := 2;

                if (hasTax) then
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;

                DBMod.TSLS_DTL.Next;
            end;

            { Footer }
            Cells.CellByA1Ref['AH' + IntToStr(21 + itemsCount)].Clear();
            Cells.CellByA1Ref['AH' + IntToStr(21 + itemsCount)].Value := sum;
            Cells.CellByA1Ref['AH' + IntToStr(21 + itemsCount)].FormatStringIndex := 2;

            if (hasTax) then
              Cells.CellByA1Ref['Z' + IntToStr(22 + itemsCount)].Value :=
                StringReplace(Cells.CellByA1Ref['Z' + IntToStr(22 + itemsCount)].Value,
                  '{0}', frmAccountParams.tbPercentageValue.Text, [rfReplaceAll, rfIgnoreCase])
            else
              Cells.CellByA1Ref['Z' + IntToStr(22 + itemsCount)].Value := 'Без НДС';

            Cells.CellByA1Ref['AH' + IntToStr(22 + itemsCount)].Clear();
            if (hasTax) then
              Cells.CellByA1Ref['AH' + IntToStr(22 + itemsCount)].Value := (sum * taxValue)/(100 + taxValue)
            else
              Cells.CellByA1Ref['AH' + IntToStr(22 + itemsCount)].Value := '';
            Cells.CellByA1Ref['AH' + IntToStr(22 + itemsCount)].FormatStringIndex := 2;

            // overall sum with item num
            sumItemsText := StringReplace(Cells.CellByA1Ref['B' + IntToStr(24 + itemsCount)].Value,
                '{0}', IntToStr(itemsCount), [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B' + IntToStr(24 + itemsCount)].Value :=
                StringReplace(sumItemsText, '{1}', FloatToStr(sum), [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B' + IntToStr(25 + itemsCount)].Value :=
                Sp3.GetRealSumma(sum, false);

            Cells.CellByA1Ref['B' + IntToStr(27 + itemsCount)].Wrap := True;
        end;

        // Экспортируем в формат Excel (подкаталог \Excel)
        fileName := excelDir + '\Счёт_' + fileName + '_' + IntToStr(GetTickCount()) + '_' + billNo + '.xls';
        xf.SaveAs(fileName);
    finally
        xf.Destroy;
    end;
end;

procedure TNaklForm.ExportDeliveryNoteToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime; orderNo: integer);
var
    billTitle, fileName, customerInfo, customerInfo2, sumItemsText, strBuff1, strBuff2, strBuff3: string;
    xf: TXLSFile;
    i, itemsCount: Integer;
    sum: Real;
begin
    xf:= TXLSFile.Create;
    try
        xf.OpenFile('..\templates\deliverynote.xls');

        with xf.Workbook.Sheets[0] do
        begin
            { Header }
            billTitle := StringReplace(Cells.CellByA1Ref['C10'].Value, '{0}',
                billNo, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['C10'].Value := StringReplace(billTitle, '{1}',
                DateToStr(billDate), [rfReplaceAll, rfIgnoreCase]);

            // Customer
            customerInfo := DBMod.TCSTCompany.Value + ', ' + DBMod.TCSTAddress.Value + ', тел. ' + DBMod.TCSTPhone.Value;
            customerInfo2 := DBMod.TCSTCompany.Value + ', ' + DBMod.TCSTAddress.Value + ', ИНН: ' + DBMod.TCSTINN.Value;
            Cells.CellByA1Ref['C7'].Value := customerInfo;
            Cells.CellByA1Ref['C9'].Value := customerInfo2;

            // Order No and Date
            Cells.CellByA1Ref['G13'].Value := orderNo;
            Cells.CellByA1Ref['I13'].Value := DateToStr(billDate);

            { Body }
            sum :=0;
            itemsCount := DBMod.TSLS_DTL.RecordCount;
            Rows.InsertRows(18, itemsCount - 1);

            // row number, item title, item amount, cost, sum
            DBMod.TSLS_DTL.First;
            for i := 1 to DBMod.TSLS_DTL.RecordCount do
            begin
                if (i <> DBMod.TSLS_DTL.RecordCount) then
                begin
                    Rows.CopyRows(17 + i, 17 + i, 18 + i);
                end;

                Cells.CellByA1Ref['A' + IntToStr(18 + i)].Value := i;
                Cells.CellByA1Ref['B' + IntToStr(18 + i)].Value := DBMod.TSLS_DTLTitle.Value;
                Cells.CellByA1Ref['K' + IntToStr(18 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value;

                Cells.CellByA1Ref['L' + IntToStr(18 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['L' + IntToStr(18 + i)].Value :=
                      CalculateSumWithoutTax(DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['L' + IntToStr(18 + i)].Value :=
                      DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['L' + IntToStr(18 + i)].FormatStringIndex := 2;

                Cells.CellByA1Ref['M' + IntToStr(18 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['M' + IntToStr(18 + i)].Value :=
                      CalculateSumWithoutTax(DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['M' + IntToStr(18 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['M' + IntToStr(18 + i)].FormatStringIndex := 2;

                if hasTax then
                  Cells.CellByA1Ref['N' + IntToStr(18 + i)].Value := taxValue
                else
                  Cells.CellByA1Ref['N' + IntToStr(18 + i)].Value := 'X';

                Cells.CellByA1Ref['O' + IntToStr(18 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['O' + IntToStr(18 + i)].Value :=
                    CalculateTax(DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['O' + IntToStr(18 + i)].Value := 'X';
                Cells.CellByA1Ref['O' + IntToStr(18 + i)].FormatStringIndex := 2;

                Cells.CellByA1Ref['P' + IntToStr(18 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['P' + IntToStr(18 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  Cells.CellByA1Ref['P' + IntToStr(18 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['P' + IntToStr(18 + i)].FormatStringIndex := 2;

                if hasTax then
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;

                DBMod.TSLS_DTL.Next;
            end;

            { Footer }
            Cells.CellByA1Ref['M' + IntToStr(19 + itemsCount)].Formula := 'SUM(M19:M' + IntToStr(18 + itemsCount) +  ')';
            Cells.CellByA1Ref['M' + IntToStr(20 + itemsCount)].Formula := 'M' + IntToStr(19 + itemsCount);

            Cells.CellByA1Ref['O' + IntToStr(19 + itemsCount)].Formula := 'SUM(O19:O' + IntToStr(18 + itemsCount) +  ')';
            Cells.CellByA1Ref['O' + IntToStr(20 + itemsCount)].Formula := 'O' + IntToStr(19 + itemsCount);

            Cells.CellByA1Ref['P' + IntToStr(19 + itemsCount)].Formula := 'SUM(P19:P' + IntToStr(18 + itemsCount) +  ')';
            Cells.CellByA1Ref['P' + IntToStr(20 + itemsCount)].Formula := 'P' + IntToStr(19 + itemsCount);

            // overall sum with item num
            Cells.CellByA1Ref['D' + IntToStr(23 + itemsCount)].Value := Sp3.GetRealSumma(itemsCount, true);

            sumItemsText := Cells.CellByA1Ref['A' + IntToStr(29 + itemsCount)].Value;
            Cells.CellByA1Ref['A' + IntToStr(29 + itemsCount)].Value :=
                StringReplace(sumItemsText, '{0}', Sp3.GetRealSumma(sum, false), [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['C' + IntToStr(38 + itemsCount)].Value :=
                DateToStr(billDate);
        end;

        // Экспортируем в формат Excel (подкаталог \Excel)
        fileName := excelDir + '\Накладная_' + fileName + '_' + IntToStr(GetTickCount()) + '_' + billNo + '.xls';
        xf.SaveAs(fileName);
    finally
        xf.Destroy;
    end;
end;

procedure TNaklForm.ExportInvoiceToExcel(excelDir: string; hasTax: boolean; taxValue: integer; billNo: string; billDate: TDateTime; orderNo: integer);
var
    billTitle, invoiceTitle, fileName, customerInfo, sumItemsText, strBuff1, strBuff2, strBuff3: string;
    xf: TXLSFile;
    i, itemsCount: Integer;
    sum: Real;
begin
    xf:= TXLSFile.Create;
    try
        xf.OpenFile('..\templates\invoice.xls');

        with xf.Workbook.Sheets[0] do
        begin
            { Header }
            billTitle := StringReplace(Cells.CellByA1Ref['B14'].Value, '{0}',
                billNo, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B14'].Value := StringReplace(billTitle, '{1}',
                DateToStr(billDate), [rfReplaceAll, rfIgnoreCase]);

            // Customer
            customerInfo := DBMod.TCSTCompany.Value + ', ' + DBMod.TCSTAddress.Value + ', тел. ' + DBMod.TCSTPhone.Value;
            Cells.CellByA1Ref['B13'].Value := StringReplace(Cells.CellByA1Ref['B13'].Value, '{0}',
                customerInfo, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B15'].Value := StringReplace(Cells.CellByA1Ref['B15'].Value, '{0}',
                DBMod.TCSTCompany.Value, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B16'].Value := StringReplace(Cells.CellByA1Ref['B16'].Value, '{0}',
                DBMod.TCSTAddress.Value, [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B17'].Value := StringReplace(Cells.CellByA1Ref['B17'].Value, '{0}',
                DBMod.TCSTINN.Value, [rfReplaceAll, rfIgnoreCase]);

            // Order No and Date
            invoiceTitle := StringReplace(Cells.CellByA1Ref['B7'].Value, '{0}',
                IntToStr(orderNo), [rfReplaceAll, rfIgnoreCase]);
            Cells.CellByA1Ref['B7'].Value := StringReplace(invoiceTitle, '{1}',
                DateToStr(billDate), [rfReplaceAll, rfIgnoreCase]);

            { Body }
            sum :=0;
            itemsCount := DBMod.TSLS_DTL.RecordCount;
            Rows.InsertRows(21, itemsCount - 1);

            // row number, item title, item amount, cost, sum
            DBMod.TSLS_DTL.First;
            for i := 1 to DBMod.TSLS_DTL.RecordCount do
            begin
                if (i <> DBMod.TSLS_DTL.RecordCount) then
                begin
                    Rows.CopyRows(20 + i, 20 + i, 21 + i);
                end;

                Cells.CellByA1Ref['B' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLTitle.Value;
                Cells.CellByA1Ref['E' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value;

                Cells.CellByA1Ref['F' + IntToStr(21 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['F' + IntToStr(21 + i)].Value :=
                    CalculateSumWithoutTax(DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['F' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['F' + IntToStr(21 + i)].FormatStringIndex := 2;

                Cells.CellByA1Ref['G' + IntToStr(21 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['G' + IntToStr(21 + i)].Value :=
                    CalculateSumWithoutTax(DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['G' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['G' + IntToStr(21 + i)].FormatStringIndex := 2;

                if hasTax then
                  Cells.CellByA1Ref['I' + IntToStr(21 + i)].Value := taxValue
                else
                  Cells.CellByA1Ref['I' + IntToStr(21 + i)].Value := 'X';

                Cells.CellByA1Ref['J' + IntToStr(21 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['J' + IntToStr(21 + i)].Value :=
                    CalculateTax(DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value, taxValue)
                else
                  Cells.CellByA1Ref['J' + IntToStr(21 + i)].Value := 'X';
                Cells.CellByA1Ref['J' + IntToStr(21 + i)].FormatStringIndex := 2;

                Cells.CellByA1Ref['K' + IntToStr(21 + i)].Clear();
                if hasTax then
                  Cells.CellByA1Ref['K' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  Cells.CellByA1Ref['K' + IntToStr(21 + i)].Value := DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                Cells.CellByA1Ref['K' + IntToStr(21 + i)].FormatStringIndex := 2;

                if hasTax then
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_NDS.Value
                else
                  sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * DBMod.TSLS_DTLGDS_COST_CLR.Value;
                  
                DBMod.TSLS_DTL.Next;
            end;

            { Footer }
            Cells.CellByA1Ref['G' + IntToStr(22 + itemsCount)].Formula := 'SUM(G22:G' + IntToStr(21 + itemsCount) +  ')';

            Cells.CellByA1Ref['J' + IntToStr(22 + itemsCount)].Formula := 'SUM(J22:J' + IntToStr(21 + itemsCount) +  ')';

            Cells.CellByA1Ref['K' + IntToStr(22 + itemsCount)].Formula := 'SUM(K22:K' + IntToStr(21 + itemsCount) +  ')';
        end;

        // Экспортируем в формат Excel (подкаталог \Excel)
        fileName := excelDir + '\Счет-фактура_' + fileName + '_' + IntToStr(GetTickCount()) + '_' + billNo + '.xls';
        xf.SaveAs(fileName);
    finally
        xf.Destroy;
    end;
end;

function TNaklForm.CalculateSumWithoutTax(sum: Double; taxValue: integer): Double;
begin
    Result := sum - (sum * taxValue)/(100 + taxValue)
end;

function TNaklForm.CalculateTax(sum: Double; taxValue: integer): Double;
begin
    Result := (sum * taxValue)/(100 + taxValue);
end;

procedure TNaklForm.profitCalcButtonClick(Sender: TObject);
var sum: real;
  i: integer;
begin
   // Расчитать сумму прибыли
   sum := 0;

   DBMod.TSLS_DTL.First;
   for i := 1 to DBMod.TSLS_DTL.RecordCount do
   begin
      if (DBMod.TGDS_DTL.Locate('ID_GDS_DTL', DBMod.TSLS_DTLID_GDS_DTL.Value, [])) then
      begin
        sum := sum + DBMod.TSLS_DTLGDS_NUMB.Value * (DBMod.TSLS_DTLGDS_COST_NDS.Value - DBMod.TGDS_DTLCOST_PURCH.Value);
      end;

      DBMod.TSLS_DTL.Next;
   end;

   MessageDlg('Прибыль составляет: ' + FormatFloat('#,##.00', sum) + ' руб.',
      mtInformation, [mbOK], 0);
end;

procedure TNaklForm.applyCashlessButtonClick(Sender: TObject);
var i: integer;
begin
  if MessageDlg('Стоимость каждой позиции будет увеличена на 6%. Данная операция не может быть отменена после применения.' + AnsiString(#13#10) +
    'Подтвердите выполнение?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes
  then exit;

  // Add extra 6% to cost
  DBMod.TSLS_DTL.First;
  for i := 1 to DBMod.TSLS_DTL.RecordCount do
  begin
    DBmod.TSLS_DTL.Edit;

    DBmod.TSLS_DTLGDS_COST_NDS.Value := DBmod.TSLS_DTLGDS_COST_NDS.Value +
      DBmod.TSLS_DTLGDS_COST_NDS.Value * 6 / 100;

    DBmod.TSLS_DTL.Post;

    DBmod.TSLS_DTL.Next;
  end;

  // Apply flag that order has Cashless payment applied
  DBMod.TSLS_GRP.Edit;
  DBMod.TSLS_GRPCashlessPayment.Value := 1;
  DBMod.TSLS_GRP.Post;
end;

procedure TNaklForm.resetClientSearchButtonClick(Sender: TObject);
begin
    DbEditEh1.Text := '';
end;

procedure TNaklForm.resetSearchButtonClick(Sender: TObject);
begin
  DbEditEh2.Text := '';
end;

end.
