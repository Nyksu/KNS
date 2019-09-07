unit PPD_SRV_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// File generated on 11.04.2002 1:08:06 from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\work\delphi\Delp5\KNS\Newserver\PPD_SRV.tlb (1)
// IID\LCID: {65E56503-5DE6-4986-A3C8-FD599EC9C28A}\0
// Helpfile: 
// DepndLst: 
//   (1) v1.0 Midas, (C:\WINNT\System32\midas.dll)
//   (2) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (3) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL, 
  MIDAS;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  PPD_SRVMajorVersion = 1;
  PPD_SRVMinorVersion = 0;

  LIBID_PPD_SRV: TGUID = '{65E56503-5DE6-4986-A3C8-FD599EC9C28A}';

  IID_IPPD_Server_2: TGUID = '{FB8350A8-2282-44EE-B30A-74DB250839DE}';
  CLASS_PPD_Server_2: TGUID = '{70217A70-9378-412E-BA66-F56D3E24E64E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPPD_Server_2 = interface;
  IPPD_Server_2Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PPD_Server_2 = IPPD_Server_2;


// *********************************************************************//
// Interface: IPPD_Server_2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB8350A8-2282-44EE-B30A-74DB250839DE}
// *********************************************************************//
  IPPD_Server_2 = interface(IAppServer)
    ['{FB8350A8-2282-44EE-B30A-74DB250839DE}']
    function  Timing: OleVariant; safecall;
    procedure StartTrans; safecall;
    procedure CommitTrans; safecall;
    procedure BackTrans; safecall;
    function  GetStateTrans: Integer; safecall;
    function  GetLastID: Integer; safecall;
    function  LogDB(lg: OleVariant; ps: OleVariant): Integer; safecall;
    function  GetData(param: OleVariant): OleVariant; safecall;
    function  RunSQL(params: OleVariant): Integer; safecall;
    function  GETNextID: Integer; safecall;
    function  DoCalculate: Integer; safecall;
    function  GetAgrForExel(AgrID: Integer): OleVariant; safecall;
    function  GetPeriodsList: OleVariant; safecall;
    function  GetResElements(id: Integer; tp: Integer; per: Integer): OleVariant; safecall;
    procedure SetVr1(vrr: Integer); safecall;
    function  GetUnitRes(id: Integer): OleVariant; safecall;
    function  GetKnsForExel(KnsID: Integer): OleVariant; safecall;
    function  UpdateSQL(dt: OleVariant): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IPPD_Server_2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB8350A8-2282-44EE-B30A-74DB250839DE}
// *********************************************************************//
  IPPD_Server_2Disp = dispinterface
    ['{FB8350A8-2282-44EE-B30A-74DB250839DE}']
    function  Timing: OleVariant; dispid 1;
    procedure StartTrans; dispid 2;
    procedure CommitTrans; dispid 3;
    procedure BackTrans; dispid 4;
    function  GetStateTrans: Integer; dispid 5;
    function  GetLastID: Integer; dispid 6;
    function  LogDB(lg: OleVariant; ps: OleVariant): Integer; dispid 7;
    function  GetData(param: OleVariant): OleVariant; dispid 8;
    function  RunSQL(params: OleVariant): Integer; dispid 9;
    function  GETNextID: Integer; dispid 10;
    function  DoCalculate: Integer; dispid 11;
    function  GetAgrForExel(AgrID: Integer): OleVariant; dispid 12;
    function  GetPeriodsList: OleVariant; dispid 13;
    function  GetResElements(id: Integer; tp: Integer; per: Integer): OleVariant; dispid 14;
    procedure SetVr1(vrr: Integer); dispid 15;
    function  GetUnitRes(id: Integer): OleVariant; dispid 16;
    function  GetKnsForExel(KnsID: Integer): OleVariant; dispid 17;
    function  UpdateSQL(dt: OleVariant): Integer; dispid 18;
    function  AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; 
                              MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function  AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                            Options: Integer; const CommandText: WideString; 
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function  AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function  AS_GetProviderNames: OleVariant; dispid 20000003;
    function  AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function  AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                            var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoPPD_Server_2 provides a Create and CreateRemote method to          
// create instances of the default interface IPPD_Server_2 exposed by              
// the CoClass PPD_Server_2. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPPD_Server_2 = class
    class function Create: IPPD_Server_2;
    class function CreateRemote(const MachineName: string): IPPD_Server_2;
  end;

implementation

uses ComObj;

class function CoPPD_Server_2.Create: IPPD_Server_2;
begin
  Result := CreateComObject(CLASS_PPD_Server_2) as IPPD_Server_2;
end;

class function CoPPD_Server_2.CreateRemote(const MachineName: string): IPPD_Server_2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PPD_Server_2) as IPPD_Server_2;
end;

end.
