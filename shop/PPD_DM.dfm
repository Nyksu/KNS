object DM: TDM
  OldCreateOrder = False
  OnCreate = DMCreate
  Left = 190
  Top = 462
  Height = 254
  Width = 400
  object cds_teh: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 8
  end
  object SockTo: TSocketConnection
    ServerGUID = '{9C9308AB-BDA0-4E49-9512-BCA87A659302}'
    ServerName = 'PpdSrv.PPDsrv1'
    AfterConnect = SockToAfterConnect
    Left = 58
    Top = 10
  end
  object cds_tmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 76
  end
  object cds_work: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 48
  end
  object cds_calc: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 110
  end
end
