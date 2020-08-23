object DBmod: TDBmod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 380
  Top = 236
  Height = 725
  Width = 1192
  object TGDS_GRP: TTable
    BeforeInsert = TGDS_GRPBeforeInsert
    BeforeEdit = TGDS_GRPBeforeEdit
    BeforePost = TGDS_GRPBeforePost
    AfterPost = TGDS_GRPAfterPost
    DatabaseName = 'AGCompound'
    Filter = 'DEL<>1'
    Filtered = True
    FieldDefs = <
      item
        Name = 'ID_GDS_GRP'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'DEL'
        DataType = ftInteger
      end
      item
        Name = 'UPLOADED'
        DataType = ftInteger
      end
      item
        Name = 'Title'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'TGDS_GRPIndex1'
        Fields = 'ID_GDS_GRP'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'title_asc'
        Fields = 'Title'
        Options = [ixCaseInsensitive]
      end>
    IndexName = 'title_asc'
    StoreDefs = True
    TableName = 'Goods_group.db'
    Left = 25
    Top = 8
    object TGDS_GRPID_GDS_GRP: TAutoIncField
      FieldName = 'ID_GDS_GRP'
      ReadOnly = True
    end
    object TGDS_GRPDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object TGDS_GRPDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TGDS_GRPUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
  end
  object DGDS_GRP: TDataSource
    DataSet = TGDS_GRP
    Left = 24
    Top = 56
  end
  object TGDS_DTL: TTable
    ObjectView = True
    BeforeInsert = TGDS_DTLBeforeInsert
    AfterInsert = TGDS_DTLAfterInsert
    BeforeEdit = TGDS_DTLBeforeEdit
    BeforePost = TGDS_DTLBeforePost
    AfterPost = TGDS_DTLAfterPost
    BeforeDelete = TGDS_DTLBeforeDelete
    AfterDelete = TGDS_DTLAfterDelete
    OnCalcFields = TGDS_DTLCalcFields
    DatabaseName = 'AGCompound'
    FieldDefs = <
      item
        Name = 'ID_GDS_DTL'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'ID_GDS_SGRP'
        DataType = ftInteger
      end
      item
        Name = 'ID_OKEY'
        DataType = ftInteger
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'COST_OPT'
        DataType = ftCurrency
      end
      item
        Name = 'COST_ROZ'
        DataType = ftCurrency
      end
      item
        Name = 'COST_ZAK'
        DataType = ftCurrency
      end
      item
        Name = 'WARE_NUM'
        DataType = ftInteger
      end
      item
        Name = 'IMAGE'
        DataType = ftGraphic
      end
      item
        Name = 'DEL'
        DataType = ftInteger
      end
      item
        Name = 'PACK_NUM'
        DataType = ftInteger
      end
      item
        Name = 'UPLOADED'
        DataType = ftInteger
      end
      item
        Name = 'COST_PURCH'
        DataType = ftCurrency
      end
      item
        Name = 'COST_WHS1'
        DataType = ftCurrency
      end
      item
        Name = 'COST_WHS2'
        DataType = ftCurrency
      end
      item
        Name = 'COST_WHS3'
        DataType = ftCurrency
      end
      item
        Name = 'IMAGE_SET'
        DataType = ftInteger
      end
      item
        Name = 'MIN_PACK'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'TGDS_DTLIndex1'
        Fields = 'ID_GDS_DTL'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'description_asc'
        Fields = 'Description'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'Goods_detail.db'
    Left = 164
    Top = 8
    object TGDS_DTLID_GDS_DTL: TAutoIncField
      FieldName = 'ID_GDS_DTL'
      ReadOnly = True
    end
    object TGDS_DTLID_GDS_SGRP: TIntegerField
      FieldName = 'ID_GDS_SGRP'
    end
    object TGDS_DTLDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 100
    end
    object TGDS_DTLDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TGDS_DTLID_OKEY: TIntegerField
      FieldName = 'ID_OKEY'
    end
    object TGDS_DTLUnitMeasuring: TStringField
      FieldKind = fkLookup
      FieldName = 'UnitMeasuring'
      LookupDataSet = TOKEY
      LookupKeyFields = 'ID_OKEY'
      LookupResultField = 'NAME'
      KeyFields = 'ID_OKEY'
      Lookup = True
    end
    object TGDS_DTLIMAGE: TGraphicField
      FieldName = 'IMAGE'
      BlobType = ftGraphic
    end
    object TGDS_DTLImageType: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ImageType'
      Calculated = True
    end
    object TGDS_DTLPACK_NUM: TIntegerField
      FieldName = 'PACK_NUM'
    end
    object TGDS_DTLSTORE_NUM: TIntegerField
      FieldKind = fkLookup
      FieldName = 'STORE_NUM'
      LookupDataSet = TSTR
      LookupKeyFields = 'ID_GDS_DTL'
      LookupResultField = 'NUM'
      KeyFields = 'ID_GDS_DTL'
      ReadOnly = True
      Lookup = True
    end
    object TGDS_DTLWARE_NUM: TIntegerField
      FieldName = 'WARE_NUM'
    end
    object TGDS_DTLUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
    object TGDS_DTLWeb: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Web'
      Calculated = True
    end
    object TGDS_DTLCOST_PURCH: TCurrencyField
      FieldName = 'COST_PURCH'
    end
    object TGDS_DTLCOST_WHS1: TCurrencyField
      FieldName = 'COST_WHS1'
    end
    object TGDS_DTLCOST_WHS2: TCurrencyField
      FieldName = 'COST_WHS2'
    end
    object TGDS_DTLCOST_WHS3: TCurrencyField
      FieldName = 'COST_WHS3'
    end
    object TGDS_DTLGroupName: TStringField
      FieldKind = fkLookup
      FieldName = 'GroupName'
      LookupDataSet = QGoodsCategory
      LookupKeyFields = 'ID_GDS_DTL'
      LookupResultField = 'GroupName'
      KeyFields = 'ID_GDS_DTL'
      Lookup = True
    end
    object TGDS_DTLSubgroupName: TStringField
      FieldKind = fkLookup
      FieldName = 'SubgroupName'
      LookupDataSet = QGoodsCategory
      LookupKeyFields = 'ID_GDS_DTL'
      LookupResultField = 'SubgroupName'
      KeyFields = 'ID_GDS_DTL'
      Lookup = True
    end
    object TGDS_DTLIMAGE_SET: TIntegerField
      FieldName = 'IMAGE_SET'
    end
    object TGDS_DTLMIN_PACK: TIntegerField
      FieldName = 'MIN_PACK'
    end
  end
  object DGDS_DTL: TDataSource
    DataSet = TGDS_DTL
    Left = 166
    Top = 56
  end
  object frReport1: TfrReport
    Dataset = frPrice
    GrayedButtons = True
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnGetValue = frReport1GetValue
    OnUserFunction = frReport1UserFunction
    Left = 24
    Top = 184
    ReportForm = {18000000}
  end
  object frPrice: TfrDBDataSet
    CloseDataSource = True
    DataSet = QPrice
    Left = 80
    Top = 184
  end
  object QPrice: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Goods_detail.ID_GDS_DTL, Goods_detail.IMAGE, Goods_detail' +
        '.DESCRIPTION as dtl_description, Goods_detail.COST_WHS1, Goods_d' +
        'etail.COST_WHS2, Goods_detail.COST_WHS3, Goods_detail.PACK_NUM, ' +
        'Goods_detail.MIN_PACK, Goods_group.DESCRIPTION + " > " + Goods_s' +
        'ubgroup.DESCRIPTION as sgrp_description'
      'FROM "Goods_detail.DB" Goods_detail'
      '   INNER JOIN "Goods_subgroup.db" Goods_subgroup'
      '   ON  (Goods_subgroup.ID_GDS_SGRP = Goods_detail.ID_GDS_SGRP)'
      '   INNER JOIN "Goods_group.db" Goods_group'
      '   ON  (Goods_group.ID_GDS_GRP = Goods_subgroup.ID_GDS_GRP)'
      'WHERE   (Goods_detail.COST_PURCH <> 0)'
      '   AND  (Goods_detail.DEL <> 1)'
      '   AND  (Goods_subgroup.DEL <> 1)'
      '   AND  (Goods_group.DEL <> 1)'
      '   AND  (Goods_group.DESCRIPTION <> "*")'
      'ORDER BY sgrp_description, dtl_description'
      ' ')
    Left = 33
    Top = 347
    object QPriceID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object QPricesgrp_description: TStringField
      FieldName = 'sgrp_description'
      Size = 63
    end
    object QPricedtl_description: TStringField
      FieldName = 'dtl_description'
      Size = 100
    end
    object QPriceIMAGE: TGraphicField
      FieldName = 'IMAGE'
      BlobType = ftGraphic
    end
    object QPricePACK_NUM: TIntegerField
      FieldName = 'PACK_NUM'
    end
    object QPriceMIN_PACK: TIntegerField
      FieldName = 'MIN_PACK'
    end
    object QPriceCOST_WHS1: TCurrencyField
      FieldName = 'COST_WHS1'
    end
    object QPriceCOST_WHS2: TCurrencyField
      FieldName = 'COST_WHS2'
    end
    object QPriceCOST_WHS3: TCurrencyField
      FieldName = 'COST_WHS3'
    end
  end
  object frShapeObject1: TfrShapeObject
    Left = 144
    Top = 184
  end
  object TCST: TTable
    ObjectView = True
    BeforeInsert = TCSTBeforeInsert
    BeforeEdit = TCSTBeforeInsert
    AfterPost = TCSTAfterPost
    AfterCancel = TCSTAfterCancel
    DatabaseName = 'AGCompound'
    FieldDefs = <
      item
        Name = 'ID_CST'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ContactName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'INN'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Address'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Del'
        DataType = ftInteger
      end
      item
        Name = 'Opt'
        DataType = ftInteger
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Email'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Guid'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'ID_COST_DCT'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'TCSTIndex1'
        Fields = 'ID_CST'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'company_desc'
        Fields = 'Company'
        Options = [ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'company_asc'
        Fields = 'Company'
        Options = [ixCaseInsensitive]
      end>
    IndexFieldNames = 'Company'
    StoreDefs = True
    TableName = 'Customers.db'
    Left = 282
    Top = 9
    object TCSTID_CST: TAutoIncField
      FieldName = 'ID_CST'
      ReadOnly = True
    end
    object TCSTCompany: TStringField
      FieldName = 'Company'
      Size = 50
    end
    object TCSTContactName: TStringField
      FieldName = 'ContactName'
      Size = 50
    end
    object TCSTINN: TStringField
      FieldName = 'INN'
      Size = 30
    end
    object TCSTAddress: TStringField
      FieldName = 'Address'
      Size = 100
    end
    object TCSTDel: TIntegerField
      FieldName = 'Del'
    end
    object TCSTOpt: TIntegerField
      FieldName = 'Opt'
    end
    object TCSTPhone: TStringField
      FieldName = 'Phone'
      Size = 100
    end
    object TCSTEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object TCSTGuid: TStringField
      FieldName = 'Guid'
      Size = 36
    end
    object TCSTID_COST_DCT: TIntegerField
      FieldName = 'ID_COST_DCT'
    end
    object TCSTProfitPercentage: TIntegerField
      FieldKind = fkLookup
      FieldName = 'ProfitPercentage'
      LookupDataSet = TDiscounts
      LookupKeyFields = 'ID_COST_DCT'
      LookupResultField = 'PROFIT_PERCENTAGE'
      KeyFields = 'ID_COST_DCT'
      Lookup = True
    end
  end
  object DCST: TDataSource
    DataSet = TCST
    Left = 282
    Top = 57
  end
  object TSLS_GRP: TTable
    BeforePost = TSLS_GRPBeforePost
    AfterPost = TSLS_GRPAfterPost
    DatabaseName = 'AGCompound'
    TableName = 'Sales_group.db'
    Left = 338
    Top = 9
    object TSLS_GRPID_SAL_GRP: TAutoIncField
      FieldName = 'ID_SAL_GRP'
      ReadOnly = True
    end
    object TSLS_GRPID_CST: TIntegerField
      FieldName = 'ID_CST'
    end
    object TSLS_GRPSDATE: TDateField
      FieldName = 'SDATE'
    end
    object TSLS_GRPSALE_SUM: TCurrencyField
      FieldName = 'SALE_SUM'
    end
    object TSLS_GRPSTORE_CHECK: TIntegerField
      FieldName = 'STORE_CHECK'
    end
    object TSLS_GRPID_WEB: TIntegerField
      FieldName = 'ID_WEB'
    end
    object TSLS_GRPOrderNo: TIntegerField
      FieldName = 'OrderNo'
    end
    object TSLS_GRPCashlessPayment: TIntegerField
      FieldName = 'CashlessPayment'
    end
  end
  object DSLS_GRP: TDataSource
    DataSet = TSLS_GRP
    Left = 336
    Top = 57
  end
  object TSLS_DTL: TTable
    BeforePost = TSLS_DTLBeforePost
    DatabaseName = 'AGCompound'
    TableName = 'Sales_detail.DB'
    Left = 400
    Top = 9
    object TSLS_DTLID_SLE_DTL: TAutoIncField
      FieldName = 'ID_SLE_DTL'
      ReadOnly = True
    end
    object TSLS_DTLID_SLE_GRP: TIntegerField
      FieldName = 'ID_SLE_GRP'
    end
    object TSLS_DTLID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object TSLS_DTLGDS_COST_NDS: TCurrencyField
      FieldName = 'GDS_COST_NDS'
    end
    object TSLS_DTLGDS_COST_CLR: TCurrencyField
      FieldName = 'GDS_COST_CLR'
    end
    object TSLS_DTLGDS_NUMB: TIntegerField
      FieldName = 'GDS_NUMB'
    end
    object TSLS_DTLComment: TStringField
      FieldName = 'Comment'
      Size = 100
    end
    object TSLS_DTLTitle: TStringField
      FieldKind = fkLookup
      FieldName = 'Title'
      LookupDataSet = TGoods4Orders
      LookupKeyFields = 'ID_GDS_DTL'
      LookupResultField = 'DESCRIPTION'
      KeyFields = 'ID_GDS_DTL'
      Size = 100
      Lookup = True
    end
  end
  object DSLS_DTL: TDataSource
    DataSet = TSLS_DTL
    Left = 400
    Top = 57
  end
  object TINF: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Info.DB'
    Left = 638
    Top = 56
    object TINFAbout: TStringField
      FieldName = 'About'
      Size = 70
    end
    object TINFNDS: TFloatField
      FieldName = 'NDS'
    end
    object TINFOrderCounter: TIntegerField
      FieldName = 'OrderCounter'
    end
  end
  object frNakl: TfrDBDataSet
    CloseDataSource = True
    DataSet = QNakl
    Left = 80
    Top = 238
  end
  object QNakl: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Sales_detail.ID_GDS_DTL, Customers.Company, OkeyCodes."VA' +
        'LUE" as Cokey, OkeyCodes.NAME as Unit, Sales_group."SDATE", Good' +
        's_detail.DESCRIPTION as GDS_DESCR, Sales_detail.GDS_COST_NDS, Sa' +
        'les_detail.GDS_COST_CLR, Sales_detail.GDS_NUMB'
      'FROM "Goods_detail.DB" Goods_detail'
      '   INNER JOIN "Sales_detail.DB" Sales_detail'
      '   ON  (Sales_detail.ID_GDS_DTL = Goods_detail.ID_GDS_DTL)'
      '   INNER JOIN "Sales_group.db" Sales_group'
      '   ON  (Sales_detail.ID_SLE_GRP = Sales_group.ID_SAL_GRP)'
      '   INNER JOIN "Customers.db" Customers'
      '   ON  (Customers.ID_CST = Sales_group.ID_CST)'
      '   INNER JOIN "OkeyCodes.db" OkeyCodes'
      '   ON  (OkeyCodes.ID_OKEY = Goods_detail.ID_OKEY)'
      'WHERE  Customers.ID_CST = :C AND Sales_group.ID_SAL_GRP = :O'
      'ORDER BY Goods_detail.DESCRIPTION')
    Left = 77
    Top = 347
    ParamData = <
      item
        DataType = ftInteger
        Name = 'C'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'O'
        ParamType = ptUnknown
        Value = 0
      end>
    object QNaklID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object QNaklCompany: TStringField
      FieldName = 'Company'
      Size = 40
    end
    object QNaklCokey: TStringField
      FieldName = 'Cokey'
      Size = 3
    end
    object QNaklUnit: TStringField
      FieldName = 'Unit'
      Size = 10
    end
    object QNaklSDATE: TDateField
      FieldName = 'SDATE'
    end
    object QNaklGDS_DESCR: TStringField
      FieldName = 'GDS_DESCR'
      Size = 100
    end
    object QNaklGDS_COST_NDS: TCurrencyField
      FieldName = 'GDS_COST_NDS'
    end
    object QNaklGDS_COST_CLR: TCurrencyField
      FieldName = 'GDS_COST_CLR'
    end
    object QNaklGDS_NUMB: TIntegerField
      FieldName = 'GDS_NUMB'
    end
  end
  object Database1: TDatabase
    AliasName = 'AGCompound'
    DatabaseName = 'db_proj'
    KeepConnection = False
    LoginPrompt = False
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 832
    Top = 552
  end
  object TSKD_GRP: TTable
    DatabaseName = 'AGCompound'
    IndexName = 'ind_desc'
    TableName = 'Sklad_group.DB'
    Left = 469
    Top = 9
    object TSKD_GRPID_SKL_GRP: TAutoIncField
      FieldName = 'ID_SKL_GRP'
      ReadOnly = True
    end
    object TSKD_GRPDESCRIPRION: TStringField
      FieldName = 'DESCRIPRION'
      Size = 30
    end
    object TSKD_GRPSDATE: TStringField
      FieldName = 'SDATE'
      Size = 15
    end
  end
  object DSKD_GRP: TDataSource
    DataSet = TSKD_GRP
    Left = 469
    Top = 57
  end
  object TSKD_DTL: TTable
    AfterInsert = TSKD_DTLAfterInsert
    AfterEdit = TSKD_DTLAfterEdit
    AfterPost = TSKD_DTLAfterPost
    AfterDelete = TSKD_DTLAfterDelete
    DatabaseName = 'AGCompound'
    IndexName = 'ind_gds_desc'
    TableName = 'Sklad_detail.DB'
    Left = 533
    Top = 9
    object TSKD_DTLID_SKL_DTL: TAutoIncField
      FieldName = 'ID_SKL_DTL'
      ReadOnly = True
    end
    object TSKD_DTLID_SKL_GRP: TIntegerField
      FieldName = 'ID_SKL_GRP'
    end
    object TSKD_DTLID_GDS_GRP: TIntegerField
      FieldName = 'ID_GDS_GRP'
    end
    object TSKD_DTLID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object TSKD_DTLGDS_DESCR: TStringField
      FieldName = 'GDS_DESCR'
      Size = 100
    end
    object TSKD_DTLNUMBER: TIntegerField
      FieldName = 'NUMBER'
    end
  end
  object DSKD_DTL: TDataSource
    DataSet = TSKD_DTL
    Left = 533
    Top = 57
  end
  object QSklad: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Sklad_group.DESCRIPRION, Sklad_group.SDATE, Sklad_detail.' +
        'GDS_DESCR, Sklad_detail.NUMBER'
      'FROM "Sklad_group.DB" Sklad_group'
      '   INNER JOIN "Sklad_detail.DB" Sklad_detail'
      '   ON  (Sklad_group.ID_SKL_GRP = Sklad_detail.ID_SKL_GRP)  '
      'ORDER BY Sklad_group.DESCRIPRION, Sklad_detail.GDS_DESCR')
    Left = 119
    Top = 347
    object QSkladDESCRIPRION: TStringField
      FieldName = 'DESCRIPRION'
      Origin = 'AGCOMPOUND."Sklad_group.DB".DESCRIPRION'
      Size = 30
    end
    object QSkladSDATE: TStringField
      FieldName = 'SDATE'
      Origin = 'AGCOMPOUND."Sklad_group.DB".SDATE'
      Size = 15
    end
    object QSkladGDS_DESCR: TStringField
      FieldName = 'GDS_DESCR'
      Origin = 'AGCOMPOUND."Sklad_detail.DB".GDS_DESCR'
      Size = 100
    end
    object QSkladNUMBER: TIntegerField
      FieldName = 'NUMBER'
      Origin = 'AGCOMPOUND."Sklad_detail.DB".NUMBER'
    end
  end
  object frSklad: TfrDBDataSet
    CloseDataSource = True
    DataSet = QSklad
    Left = 80
    Top = 288
  end
  object TEE: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Essential_Elements.db'
    Left = 636
    Top = 8
    object TEESeller: TStringField
      FieldName = 'Seller'
      Size = 50
    end
    object TEEAddress: TStringField
      FieldName = 'Address'
      Size = 70
    end
    object TEEINN: TStringField
      FieldName = 'INN'
      Size = 30
    end
    object TEERsht: TStringField
      FieldName = 'Rsht'
      Size = 70
    end
    object TEEBik: TStringField
      FieldName = 'Bik'
      Size = 15
    end
    object TEEKsht: TStringField
      FieldName = 'Ksht'
      Size = 30
    end
  end
  object TOKEY: TTable
    DatabaseName = 'AGCompound'
    IndexFieldNames = 'NAME'
    TableName = 'OkeyCodes.DB'
    Left = 696
    Top = 8
    object TOKEYID_OKEY: TAutoIncField
      FieldName = 'ID_OKEY'
      ReadOnly = True
    end
    object TOKEYNAME: TStringField
      FieldName = 'NAME'
      Size = 10
    end
    object TOKEYDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 25
    end
    object TOKEYVALUE: TStringField
      FieldName = 'VALUE'
      Size = 3
    end
  end
  object DOKEY: TDataSource
    DataSet = TOKEY
    Left = 696
    Top = 56
  end
  object frInvoice: TfrDBDataSet
    CloseDataSource = True
    DataSet = QNakl
    Left = 144
    Top = 238
  end
  object ExportPriceExcelFile: TXLSExportFile
    Left = 56
    Top = 416
  end
  object XLSExportPriceDataSource: TXLSExportDataSource
    XLSExportFile = ExportPriceExcelFile
    DataSource = DQPriceExcel
    Options = []
    OnSaveTitle = XLSExportPriceDataSourceSaveTitle
    Left = 56
    Top = 472
  end
  object DQPriceExcel: TDataSource
    DataSet = QPriceExcel
    Left = 139
    Top = 580
  end
  object QPriceExcel: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Goods_detail.ID_GDS_DTL, Goods_detail.IMAGE, Goods_detail' +
        '.DESCRIPTION as dtl_description, Goods_detail.COST_WHS1, Goods_d' +
        'etail.COST_WHS2, Goods_detail.COST_WHS3, OkeyCodes.NAME as OKCOD' +
        'E, Goods_detail.PACK_NUM, Goods_group.DESCRIPTION + " > " + Good' +
        's_subgroup.DESCRIPTION as sgrp_description'
      'FROM "Goods_detail.DB" Goods_detail'
      '   INNER JOIN "Goods_subgroup.db" Goods_subgroup'
      '   ON  (Goods_subgroup.ID_GDS_SGRP = Goods_detail.ID_GDS_SGRP)'
      '   INNER JOIN "Goods_group.db" Goods_group'
      '   ON  (Goods_group.ID_GDS_GRP = Goods_subgroup.ID_GDS_GRP)'
      '   INNER JOIN "OkeyCodes.db" OkeyCodes'
      '   ON  (OkeyCodes.ID_OKEY = Goods_detail.ID_OKEY)'
      
        'WHERE   ( (Goods_detail.COST_OPT <> 0)  OR  (Goods_detail.COST_R' +
        'OZ <> 0)  OR  (Goods_detail.COST_ZAK <> 0) )'
      '   AND  (Goods_detail.DEL <> 1)'
      '   AND  (Goods_subgroup.DEL <> 1)'
      '   AND  (Goods_group.DEL <> 1)'
      '   AND  (Goods_group.DESCRIPTION <> "*")'
      'ORDER BY sgrp_description, dtl_description'
      ' '
      ' '
      ' '
      ' '
      ' ')
    Left = 140
    Top = 528
    object QPriceExcelID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object QPriceExcelsgrp_description: TStringField
      FieldName = 'sgrp_description'
      Size = 63
    end
    object QPriceExceldtl_description: TStringField
      FieldName = 'dtl_description'
      Size = 100
    end
    object QPriceExcelPACK_NUM: TIntegerField
      FieldName = 'PACK_NUM'
    end
    object QPriceExcelCOST_WHS1: TCurrencyField
      FieldName = 'COST_WHS1'
    end
    object QPriceExcelCOST_WHS2: TCurrencyField
      FieldName = 'COST_WHS2'
    end
    object QPriceExcelCOST_WHS3: TCurrencyField
      FieldName = 'COST_WHS3'
    end
  end
  object QCatalogExcel: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      'SELECT Goods_detail.ID_GDS_DTL, Goods_detail.IMAGE'
      'FROM "Goods_detail.DB" Goods_detail'
      'WHERE Goods_detail.DEL <> 1'
      'ORDER BY Goods_detail.ID_GDS_DTL'
      ' ')
    Left = 56
    Top = 528
    object QCatalogExcelID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
      Origin = 'AGCOMPOUND."Goods_detail.DB".ID_GDS_DTL'
    end
    object QCatalogExcelIMAGE: TGraphicField
      FieldName = 'IMAGE'
      Origin = 'AGCOMPOUND."Goods_detail.DB".IMAGE'
      BlobType = ftGraphic
    end
  end
  object DQCatalogExcel: TDataSource
    DataSet = QPriceExcel
    Left = 55
    Top = 580
  end
  object XLSExportNakladnayaDataSource: TXLSExportDataSource
    XLSExportFile = ExportPriceExcelFile
    DataSource = DQNakladnayaExcel
    Options = []
    OnSaveTitle = XLSExportNakladnayaDataSourceSaveTitle
    Left = 255
    Top = 469
  end
  object DQNakladnayaExcel: TDataSource
    DataSet = QNakladnayaExcel
    Left = 259
    Top = 580
  end
  object ExportNakladnayaExcelFile: TXLSExportFile
    Left = 256
    Top = 422
  end
  object QNakladnayaExcel: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Sales_detail.ID_GDS_DTL, Goods_detail.DESCRIPTION as GDS_' +
        'DESCR, Sales_detail.GDS_COST_CLR, Sales_detail.GDS_NUMB, Sales_g' +
        'roup."SDATE", OkeyCodes.NAME AS OKCODE'
      'FROM "Goods_detail.DB" Goods_detail'
      '   INNER JOIN "Sales_detail.DB" Sales_detail'
      '   ON  (Sales_detail.ID_GDS_DTL = Goods_detail.ID_GDS_DTL)'
      '   INNER JOIN "Sales_group.db" Sales_group'
      '   ON  (Sales_detail.ID_SLE_GRP = Sales_group.ID_SAL_GRP)  '
      '   INNER JOIN "Customers.db" Customers'
      '   ON  (Customers.ID_CST = Sales_group.ID_CST)  '
      '   INNER JOIN "OkeyCodes.db" OkeyCodes'
      '   ON  (OkeyCodes.ID_OKEY = Goods_detail.ID_OKEY)'
      'WHERE  Customers.ID_CST = :C AND Sales_group.ID_SAL_GRP = :O'
      'ORDER BY Goods_detail.DESCRIPTION')
    Left = 258
    Top = 526
    ParamData = <
      item
        DataType = ftInteger
        Name = 'C'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'O'
        ParamType = ptUnknown
        Value = 0
      end>
    object QNakladnayaExcelID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object QNakladnayaExcelGDS_DESCR: TStringField
      FieldName = 'GDS_DESCR'
      Size = 100
    end
    object QNakladnayaExcelGDS_COST_CLR: TCurrencyField
      FieldName = 'GDS_COST_CLR'
    end
    object QNakladnayaExcelGDS_NUMB: TIntegerField
      FieldName = 'GDS_NUMB'
    end
    object QNakladnayaExcelSDATE: TDateField
      FieldName = 'SDATE'
    end
    object QNakladnayaExcelOKCODE: TStringField
      FieldName = 'OKCODE'
      Size = 10
    end
  end
  object TGDS_SGRP: TTable
    BeforeInsert = TGDS_SGRPBeforeInsert
    BeforeEdit = TGDS_SGRPBeforeEdit
    BeforePost = TGDS_SGRPBeforePost
    AfterPost = TGDS_SGRPAfterPost
    DatabaseName = 'AGCompound'
    Filter = 'DEL<>1'
    Filtered = True
    IndexName = 'title_asc'
    TableName = 'Goods_subgroup.db'
    Left = 93
    Top = 8
    object TGDS_SGRPID_GDS_SGRP: TAutoIncField
      FieldName = 'ID_GDS_SGRP'
      ReadOnly = True
    end
    object TGDS_SGRPID_GDS_GRP: TIntegerField
      FieldName = 'ID_GDS_GRP'
    end
    object TGDS_SGRPDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object TGDS_SGRPDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TGDS_SGRPUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
    object TGDS_SGRPGroupName: TStringField
      FieldKind = fkLookup
      FieldName = 'GroupName'
      LookupDataSet = TGDS_GRP
      LookupKeyFields = 'ID_GDS_GRP'
      LookupResultField = 'DESCRIPTION'
      KeyFields = 'ID_GDS_GRP'
      Lookup = True
    end
  end
  object DGDS_SGRP: TDataSource
    DataSet = TGDS_SGRP
    Left = 96
    Top = 56
  end
  object TSTR: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Store.db'
    Left = 648
    Top = 136
    object TSTRID_STR: TAutoIncField
      FieldName = 'ID_STR'
      ReadOnly = True
    end
    object TSTRID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object TSTRNUM: TIntegerField
      FieldName = 'NUM'
    end
  end
  object DSTR: TDataSource
    DataSet = QSTR
    Left = 696
    Top = 192
  end
  object QSTR: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Goods_detail.ID_GDS_DTL, Goods_detail.DESCRIPTION, Store.' +
        'NUM'
      'FROM "Store.db" Store'
      '   INNER JOIN "Goods_detail.DB" Goods_detail'
      '   ON  (Goods_detail.ID_GDS_DTL = Store.ID_GDS_DTL)'
      
        'WHERE Goods_detail.ID_GDS_SGRP >= :LOW AND Goods_detail.ID_GDS_S' +
        'GRP <= :HIGH AND Goods_detail.DEL <> 1'
      'ORDER BY Goods_detail.DESCRIPTION')
    Left = 696
    Top = 136
    ParamData = <
      item
        DataType = ftInteger
        Name = 'LOW'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'HIGH'
        ParamType = ptInput
        Value = 0
      end>
    object QSTRID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
      Origin = 'AGCOMPOUND."Goods_detail.DB".ID_GDS_DTL'
    end
    object QSTRDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AGCOMPOUND."Goods_detail.DB".DESCRIPTION'
      Size = 100
    end
    object QSTRNUM: TIntegerField
      FieldName = 'NUM'
      Origin = 'AGCOMPOUND."Store.DB".NUM'
    end
  end
  object QGroupsWeb: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      'SELECT ID_GDS_GRP, DESCRIPTION, DEL'
      'FROM "Goods_group.DB" Goods_group'
      'WHERE  UPLOADED = 0 '
      'ORDER BY DESCRIPTION')
    Left = 824
    Top = 8
    object QGroupsWebID_GDS_GRP: TIntegerField
      FieldName = 'ID_GDS_GRP'
      Origin = 'AGCOMPOUND."Goods_group.DB".ID_GDS_GRP'
    end
    object QGroupsWebDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AGCOMPOUND."Goods_group.DB".DESCRIPTION'
      Size = 30
    end
    object QGroupsWebDEL: TIntegerField
      FieldName = 'DEL'
      Origin = 'AGCOMPOUND."Goods_group.DB".DEL'
    end
  end
  object QSubgroupsWeb: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      'SELECT ID_GDS_SGRP, ID_GDS_GRP, DESCRIPTION, DEL'
      'FROM "Goods_subgroup.DB" Goods_subgroup'
      'WHERE  UPLOADED = 0 and ID_GDS_GRP = :A'
      'ORDER BY DESCRIPTION')
    Left = 826
    Top = 72
    ParamData = <
      item
        DataType = ftInteger
        Name = 'A'
        ParamType = ptInput
        Value = 0
      end>
    object QSubgroupsWebID_GDS_GRP: TIntegerField
      FieldName = 'ID_GDS_GRP'
      Origin = 'AGCOMPOUND."Goods_group.DB".ID_GDS_GRP'
    end
    object QSubgroupsWebID_GDS_SGRP: TIntegerField
      FieldName = 'ID_GDS_SGRP'
      Origin = 'AGCOMPOUND."Goods_subgroup.DB".ID_GDS_SGRP'
    end
    object QSubgroupsWebDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AGCOMPOUND."Goods_group.DB".DESCRIPTION'
      Size = 30
    end
    object QSubgroupsWebDEL: TIntegerField
      FieldName = 'DEL'
      Origin = 'AGCOMPOUND."Goods_group.DB".DEL'
    end
  end
  object QGoodsWeb: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'SELECT Goods_detail.ID_GDS_DTL, Goods_detail.ID_GDS_SGRP, Goods_' +
        'detail.DESCRIPTION, OkeyCodes.Name MeasureUnits, Goods_detail.CO' +
        'ST_WHS1, Goods_detail.COST_WHS2, Goods_detail.COST_WHS3, Goods_d' +
        'etail.IMAGE, Goods_detail.PACK_NUM, Goods_detail.MIN_PACK, Goods' +
        '_detail.DEL, Goods_detail.IMAGE_SET'
      'FROM "Goods_detail.DB" Goods_detail'
      '   INNER JOIN "OkeyCodes.db" OkeyCodes'
      '   ON  (Goods_detail.ID_OKEY = OkeyCodes.ID_OKEY)'
      
        'WHERE  Goods_detail.UPLOADED = 0 and Goods_detail.ID_GDS_SGRP = ' +
        ':A'
      'ORDER BY Goods_detail.DESCRIPTION')
    Left = 824
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'A'
        ParamType = ptInput
        Value = 0
      end>
    object QGoodsWebID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
      Origin = 'AGCOMPOUND."Goods_detail.DB".ID_GDS_DTL'
    end
    object QGoodsWebID_GDS_SGRP: TIntegerField
      FieldName = 'ID_GDS_SGRP'
      Origin = 'AGCOMPOUND."Goods_detail.DB".ID_GDS_SGRP'
    end
    object QGoodsWebDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AGCOMPOUND."Goods_detail.DB".DESCRIPTION'
      Size = 100
    end
    object QGoodsWebMeasureUnits: TStringField
      FieldName = 'MeasureUnits'
      Origin = 'AGCOMPOUND."OkeyCodes.DB".NAME'
      Size = 10
    end
    object QGoodsWebIMAGE: TGraphicField
      FieldName = 'IMAGE'
      Origin = 'AGCOMPOUND."Goods_detail.DB".IMAGE'
      BlobType = ftGraphic
    end
    object QGoodsWebPACK_NUM: TIntegerField
      FieldName = 'PACK_NUM'
      Origin = 'AGCOMPOUND."Goods_detail.DB".PACK_NUM'
    end
    object QGoodsWebMIN_PACK: TIntegerField
      FieldName = 'MIN_PACK'
      Origin = 'AGCOMPOUND."Goods_detail.DB".MIN_PACK'
    end
    object QGoodsWebDEL: TIntegerField
      FieldName = 'DEL'
      Origin = 'AGCOMPOUND."Goods_detail.DB".DEL'
    end
    object QGoodsWebCOST_WHS1: TCurrencyField
      FieldName = 'COST_WHS1'
      Origin = 'AGCOMPOUND."Goods_detail.DB".COST_WHS1'
    end
    object QGoodsWebCOST_WHS2: TCurrencyField
      FieldName = 'COST_WHS2'
      Origin = 'AGCOMPOUND."Goods_detail.DB".COST_WHS2'
    end
    object QGoodsWebCOST_WHS3: TCurrencyField
      FieldName = 'COST_WHS3'
      Origin = 'AGCOMPOUND."Goods_detail.DB".COST_WHS3'
    end
    object QGoodsWebIMAGE_SET: TIntegerField
      FieldName = 'IMAGE_SET'
      Origin = 'AGCOMPOUND."Goods_detail.DB".IMAGE_SET'
    end
  end
  object TGroupsWebUpdate: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Goods_group.DB'
    Left = 824
    Top = 208
    object TGroupsWebUpdateID_GDS_GRP: TAutoIncField
      FieldName = 'ID_GDS_GRP'
      ReadOnly = True
    end
    object TGroupsWebUpdateDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object TGroupsWebUpdateDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TGroupsWebUpdateUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
  end
  object TSubgroupsWebUpdate: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Goods_subgroup.DB'
    Left = 824
    Top = 264
    object TSubgroupsWebUpdateID_GDS_SGRP: TAutoIncField
      FieldName = 'ID_GDS_SGRP'
      ReadOnly = True
    end
    object TSubgroupsWebUpdateDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object TSubgroupsWebUpdateDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TSubgroupsWebUpdateID_GDS_GRP: TIntegerField
      FieldName = 'ID_GDS_GRP'
    end
    object TSubgroupsWebUpdateUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
  end
  object TGoodsWebUpdate: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Goods_detail.DB'
    Left = 824
    Top = 328
    object TGoodsWebUpdateID_GDS_DTL: TAutoIncField
      FieldName = 'ID_GDS_DTL'
      ReadOnly = True
    end
    object TGoodsWebUpdateID_GDS_SGRP: TIntegerField
      FieldName = 'ID_GDS_SGRP'
    end
    object TGoodsWebUpdateID_OKEY: TIntegerField
      FieldName = 'ID_OKEY'
    end
    object TGoodsWebUpdateDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 100
    end
    object TGoodsWebUpdateWARE_NUM: TIntegerField
      FieldName = 'WARE_NUM'
    end
    object TGoodsWebUpdateIMAGE: TGraphicField
      FieldName = 'IMAGE'
      BlobType = ftGraphic
    end
    object TGoodsWebUpdateDEL: TIntegerField
      FieldName = 'DEL'
    end
    object TGoodsWebUpdatePACK_NUM: TIntegerField
      FieldName = 'PACK_NUM'
    end
    object TGoodsWebUpdateUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
    object TGoodsWebUpdateCOST_PURCH: TCurrencyField
      FieldName = 'COST_PURCH'
    end
    object TGoodsWebUpdateCOST_WHS1: TCurrencyField
      FieldName = 'COST_WHS1'
    end
    object TGoodsWebUpdateCOST_WHS2: TCurrencyField
      FieldName = 'COST_WHS2'
    end
    object TGoodsWebUpdateCOST_WHS3: TCurrencyField
      FieldName = 'COST_WHS3'
    end
    object TGoodsWebUpdateIMAGE_SET: TIntegerField
      FieldName = 'IMAGE_SET'
    end
  end
  object QGoodsCategory: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      
        'select gd.ID_GDS_DTL, gg.Description as GroupName, gs.Descriptio' +
        'n as SubgroupName'
      'from "Goods_detail" gd'
      
        #9'Inner join "Goods_subgroup" gs on gs.ID_GDS_SGRP = gd.ID_GDS_SG' +
        'RP'
      #9'Inner join "Goods_group" gg on gg.ID_GDS_GRP = gs.ID_GDS_GRP')
    Left = 186
    Top = 348
    object QGoodsCategoryID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
    end
    object QGoodsCategoryGroupName: TStringField
      FieldName = 'GroupName'
      Size = 30
    end
    object QGoodsCategorySubgroupName: TStringField
      FieldName = 'SubgroupName'
      Size = 30
    end
  end
  object TDiscounts: TTable
    ObjectView = True
    BeforePost = TDiscountsBeforePost
    DatabaseName = 'AGCompound'
    Filter = 'DEL<>1'
    IndexName = 'ind_asc'
    TableName = 'CostDiscounts.DB'
    Left = 229
    Top = 8
    object TDiscountsID_COST_DCT: TIntegerField
      FieldName = 'ID_COST_DCT'
    end
    object TDiscountsPROFIT_PERCENTAGE: TFloatField
      FieldName = 'PROFIT_PERCENTAGE'
    end
    object TDiscountsSTART_SUMM: TCurrencyField
      FieldName = 'START_SUMM'
    end
    object TDiscountsUPLOADED: TIntegerField
      FieldName = 'UPLOADED'
    end
    object TDiscountsDEL: TIntegerField
      FieldName = 'DEL'
    end
  end
  object DDiscounts: TDataSource
    DataSet = TDiscounts
    Left = 230
    Top = 56
  end
  object TGoods4Orders: TTable
    DatabaseName = 'AGCompound'
    TableName = 'Goods_detail.db'
    Left = 400
    Top = 115
    object TGoods4OrdersID_GDS_DTL: TAutoIncField
      FieldName = 'ID_GDS_DTL'
      ReadOnly = True
    end
    object TGoods4OrdersDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 100
    end
  end
  object QCustomerLookup: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      'SELECT Customers.ID_CST'
      'FROM "Customers.DB" Customers'
      'WHERE upper(Customers.Company) LIKE '#39'%'#39' + upper(:C) + '#39'%'#39' OR'
      '   upper(Customers.ContactName) LIKE '#39'%'#39' + upper(:C) + '#39'%'#39' OR'
      '   upper(Customers.Address) LIKE '#39'%'#39' + upper(:C) + '#39'%'#39' OR'
      '   upper(Customers.Email) LIKE '#39'%'#39' + upper(:C) + '#39'%'#39
      'ORDER BY Customers.ID_CST')
    Left = 461
    Top = 348
    ParamData = <
      item
        DataType = ftString
        Name = 'C'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'C'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'C'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'C'
        ParamType = ptUnknown
      end>
    object QCustomerLookupID_CST: TIntegerField
      FieldName = 'ID_CST'
      Origin = 'AGCOMPOUND."Customers.DB".ID_CST'
    end
  end
  object QPriceLookup: TQuery
    DatabaseName = 'AGCompound'
    SQL.Strings = (
      'SELECT Price.ID_GDS_DTL'
      'FROM "Goods_detail.DB" Price'
      'WHERE upper(Price.DESCRIPTION) LIKE '#39'%'#39' + upper(:D) + '#39'%'#39
      'ORDER BY Price.ID_GDS_DTL')
    Left = 377
    Top = 349
    ParamData = <
      item
        DataType = ftString
        Name = 'D'
        ParamType = ptUnknown
      end>
    object QPriceLookupID_GDS_DTL: TIntegerField
      FieldName = 'ID_GDS_DTL'
      Origin = 'AGCOMPOUND."Goods_detail.DB".ID_GDS_DTL'
    end
  end
end
