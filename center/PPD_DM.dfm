object DM: TDM
  OldCreateOrder = False
  OnCreate = DMCreate
  Left = 190
  Top = 462
  Height = 254
  Width = 400
  object SockTo: TSocketConnection
    ServerGUID = '{812FB623-9A70-11D5-88E7-006008703EA4}'
    ServerName = 'KNS_srv.KNS_Server'
    AfterConnect = SocktoAfterConnect
    Host = 'nyk'
    Left = 42
    Top = 24
  end
  object cds_teh: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 46
    Top = 92
  end
end
