object PPD_Server_2: TPPD_Server_2
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Left = 174
  Top = 201
  Height = 472
  Width = 536
  object IBDB: TIBDatabase
    DatabaseName = 'c:\base\PPD\ppdb.gdb'
    Params.Strings = (
      'user_name=PPD'
      'password=pfukeirf'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 10
    Top = 8
  end
  object IBTrans: TIBTransaction
    Active = False
    DefaultDatabase = IBDB
    DefaultAction = TARollback
    Left = 10
    Top = 62
  end
  object q_SQL: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    CachedUpdates = False
    SQL.Strings = (
      'Select * from SQL_CODES'
      'where'
      ' ID=:id'
      'and ROLES_ID>=:pravo')
    Left = 54
    Top = 12
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pravo'
        ParamType = ptUnknown
      end>
  end
  object q_users: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    CachedUpdates = False
    SQL.Strings = (
      'Select * from USERS'
      'where'
      'LOGIN_NAME=:lname'
      'and state=0')
    Left = 54
    Top = 66
    ParamData = <
      item
        DataType = ftString
        Name = 'lname'
        ParamType = ptInput
      end>
  end
  object sp_next_id: TIBStoredProc
    Database = IBDB
    Transaction = IBTrans
    StoredProcName = 'GET_NEXT_ID'
    Params = <
      item
        DataType = ftInteger
        Name = 'ID_KOD'
        ParamType = ptOutput
      end>
    Left = 100
    Top = 14
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_KOD'
        ParamType = ptOutput
      end>
  end
  object q_default: TIBQuery
    Database = IBDB
    Transaction = IBTrans
    CachedUpdates = False
    Left = 58
    Top = 128
  end
  object pr_teh: TDataSetProvider
    DataSet = q_default
    Constraints = True
    Left = 60
    Top = 186
  end
  object cds_teh: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pr_teh'
    Left = 14
    Top = 126
  end
  object cds_work: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 12
    Top = 190
  end
  object DBtmp: TIBDatabase
    Params.Strings = (
      'USER '#39'PPD'#39' PASSWORD '#39'pfukeirf'#39
      'PAGE_SIZE 4096'
      'DEFAULT CHARACTER SET WIN1251')
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 234
    Top = 14
  end
  object IBTransTMP: TIBTransaction
    Active = False
    DefaultDatabase = DBtmp
    Left = 236
    Top = 70
  end
  object q_tmp: TIBQuery
    Database = DBtmp
    Transaction = IBTransTMP
    CachedUpdates = False
    Left = 236
    Top = 130
  end
  object pr_tmp: TDataSetProvider
    DataSet = q_tmp
    Constraints = True
    Left = 232
    Top = 186
  end
  object cds_tmp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pr_tmp'
    Left = 232
    Top = 236
  end
  object cds_calc: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 278
  end
end
