object dm: Tdm
  OldCreateOrder = False
  Height = 307
  Width = 651
  object IBDatabase1: TIBDatabase
    DatabaseName = 
      'C:\'#1061#1080#1084#1096#1080#1072#1096#1074#1080#1083#1080'\'#1059#1095#1077#1073#1072'\() 3 '#1050#1091#1088#1089'\6 '#1089#1077#1084#1077#1089#1090#1088'\'#1044#1077#1083#1100#1092#1080'\'#1048#1044#1047'\DataBase\MY3' +
      '21.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 168
    Top = 32
  end
  object IBTransaction1: TIBTransaction
    Left = 272
    Top = 32
  end
  object tClient: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'FIRM'
    UniDirectional = False
    Left = 40
    Top = 104
    object tClientID: TLargeintField
      Alignment = taCenter
      DisplayLabel = #8470
      DisplayWidth = 8
      FieldName = 'ID'
      Required = True
    end
    object tClientNAME: TIBStringField
      DisplayLabel = #1048#1084#1103' / '#1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'NAME'
      Size = 50
    end
    object tClientINN: TIBStringField
      Alignment = taCenter
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Size = 12
    end
    object tClientADDRESS: TIBStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'ADDRESS'
      Size = 100
    end
  end
  object spClientAdd: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'FIRM_ADD'
    Left = 40
    Top = 168
    ParamData = <
      item
        DataType = ftString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_ADDRESS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_INN'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'OUT_ID'
        ParamType = ptOutput
      end>
  end
  object spClientEdit: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'FIRM_EDIT'
    Left = 40
    Top = 232
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'IN_ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_ADDRESS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_INN'
        ParamType = ptInput
      end>
  end
  object tGoods: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction2
    AfterOpen = tGoodsAfterOpen
    AfterRefresh = tGoodsAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ReadOnly = True
    TableName = 'GOODS'
    UniDirectional = False
    Left = 152
    Top = 104
  end
  object spGoodsAdd: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'GOODS_ADD'
    Left = 152
    Top = 168
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'OUT_ID'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_MEASURE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'IN_VAT'
        ParamType = ptInput
      end>
  end
  object spGoodsEdit: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'GOODS_EDIT'
    Left = 152
    Top = 240
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'IN_ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_MEASURE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'IN_VAT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'IN_QNT'
        ParamType = ptInput
      end>
  end
  object qFutura: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select futura.*, firm.name, firm.inn,'
      
        '    (select sum(summa) from futura_info where futura_id = futura' +
        '.id ) as summa,'
      
        '    (select sum(vat_summa) from futura_info where futura_id = fu' +
        'tura.id) as vat_summa'
      ' from futura inner join firm on futura.client_id = firm.id'
      'where futura.futura_type = :in_type'
      'order by futura.futura_date, futura.id')
    Left = 320
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'in_type'
        ParamType = ptUnknown
      end>
    object qFuturaID: TLargeintField
      FieldName = 'ID'
      Origin = 'FUTURA.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object qFuturaFUTURA_TYPE: TSmallintField
      FieldName = 'FUTURA_TYPE'
      Origin = 'FUTURA.FUTURA_TYPE'
      Visible = False
    end
    object qFuturaFUTURA_NO: TIBStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
      FieldName = 'FUTURA_NO'
      Origin = 'FUTURA.FUTURA_NO'
      Size = 10
    end
    object qFuturaNAME: TIBStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'NAME'
      Origin = 'FIRM.NAME'
      Size = 50
    end
    object qFuturaFUTURA_DATE: TDateField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'FUTURA_DATE'
      Origin = 'FUTURA.FUTURA_DATE'
    end
    object qFuturaCLIENT_ID: TLargeintField
      FieldName = 'CLIENT_ID'
      Origin = 'FUTURA.CLIENT_ID'
      Required = True
      Visible = False
    end
    object qFuturaINN: TIBStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Origin = 'FIRM.INN'
      Size = 12
    end
    object qFuturaSUMMA: TIBBCDField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 8
      FieldName = 'SUMMA'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '##0.00'
      Precision = 18
      Size = 2
    end
    object qFuturaVAT_SUMMA: TIBBCDField
      DisplayLabel = #1042' '#1090'.'#1095'. '#1053#1044#1057
      DisplayWidth = 8
      FieldName = 'VAT_SUMMA'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '##0.00'
      Precision = 18
      Size = 2
    end
    object qFuturaDONE: TIBStringField
      Alignment = taCenter
      DisplayLabel = #1042#1099#1087#1086#1083#1085#1077#1085
      DisplayWidth = 3
      FieldName = 'DONE'
      Origin = 'FUTURA.DONE'
      Size = 10
    end
  end
  object spFuturaAdd: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'FUTURA_ADD'
    Left = 336
    Top = 200
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'OUT_ID'
        ParamType = ptOutput
      end
      item
        DataType = ftSmallint
        Name = 'IN_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'IN_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_NO'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'IN_F_ID'
        ParamType = ptInput
      end>
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 376
    Top = 32
  end
  object spFuturaInfoAdd: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction1
    StoredProcName = 'FUTURA_INFO_ADD'
    Left = 424
    Top = 200
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'IN_N_ID'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'IN_G_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'IN_QNT'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'IN_SUMMA'
        ParamType = ptInput
      end>
  end
  object qFuturaInfo: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from futura_info where futura_id = :inNID'
      'order by G_NAME')
    Left = 416
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'inNID'
        ParamType = ptUnknown
      end>
    object qFuturaInfoFUTURA_ID: TLargeintField
      FieldName = 'FUTURA_ID'
      Origin = 'FUTURA_INFO.FUTURA_ID'
      Required = True
      Visible = False
    end
    object qFuturaInfoGOODS_ID: TLargeintField
      FieldName = 'GOODS_ID'
      Origin = 'FUTURA_INFO.GOODS_ID'
      Required = True
      Visible = False
    end
    object qFuturaInfoG_NAME: TIBStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldKind = fkInternalCalc
      FieldName = 'G_NAME'
      Origin = 'FUTURA_INFO.G_NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qFuturaInfoPRICE: TIBBCDField
      DisplayLabel = #1062#1077#1085#1072
      DisplayWidth = 8
      FieldKind = fkInternalCalc
      FieldName = 'PRICE'
      Origin = 'FUTURA_INFO.PRICE'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qFuturaInfoQUANTITY: TFMTBCDField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      DisplayWidth = 10
      FieldName = 'QUANTITY'
      Origin = 'FUTURA_INFO.QUANTITY'
      Precision = 18
      Size = 5
    end
    object qFuturaInfoG_MESURE: TIBStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084'. '
      DisplayWidth = 6
      FieldKind = fkInternalCalc
      FieldName = 'G_MESURE'
      Origin = 'FUTURA_INFO.G_MESURE'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qFuturaInfoG_VAT: TFMTBCDField
      DisplayLabel = #1053#1044#1057' (%)'
      DisplayWidth = 8
      FieldKind = fkInternalCalc
      FieldName = 'G_VAT'
      Origin = 'FUTURA_INFO.G_VAT'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '##0.00'
      Precision = 18
      Size = 5
    end
    object qFuturaInfoSUMMA: TIBBCDField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 10
      FieldName = 'SUMMA'
      Origin = 'FUTURA_INFO.SUMMA'
      DisplayFormat = '##0.00'
      Precision = 18
      Size = 2
    end
    object qFuturaInfoVAT_SUMMA: TIBBCDField
      DisplayLabel = #1042' '#1090'.'#1095'. '#1053#1044#1057
      DisplayWidth = 8
      FieldKind = fkInternalCalc
      FieldName = 'VAT_SUMMA'
      Origin = 'FUTURA_INFO.VAT_SUMMA'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '##0.00'
      Precision = 18
      Size = 2
    end
  end
  object qTmp: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 560
    Top = 136
  end
  object spFindDelivery: TIBStoredProc
    Database = IBDatabase1
    Transaction = IBTransaction2
    StoredProcName = 'FIND_DELIVERY'
    Left = 544
    Top = 232
    ParamData = <
      item
        DataType = ftLargeint
        Name = 'OUT_ID'
        ParamType = ptOutput
      end
      item
        DataType = ftDate
        Name = 'IN_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'IN_CL_ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IN_NO'
        ParamType = ptInput
      end>
  end
end
