object DM: TDM
  OldCreateOrder = False
  OnCreate = DMCreate
  Left = 190
  Top = 462
  Height = 254
  Width = 400
  object SockTo: TSocketConnection
    ServerGUID = '{9C9308AB-BDA0-4E49-9512-BCA87A659302}'
    ServerName = 'PpdSrv.PPDsrv1'
    AfterConnect = SocktoAfterConnect
    Left = 42
    Top = 26
  end
  object cds_teh: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 46
    Top = 92
  end
end
