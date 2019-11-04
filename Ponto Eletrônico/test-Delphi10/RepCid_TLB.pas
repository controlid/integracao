unit RepCid_TLB;

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

// $Rev: 17244 $
// File generated on 23/03/2016 17:53:14 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Sistemas\TesteRepCid\RepCid.tlb (1)
// LIBID: {2E6553EC-AA8B-40CC-AAB3-7C5314781D63}
// LCID: 0
// Helpfile:
// HelpString: Comunica��o com REP
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
// Errors:
//   Hint: TypeInfo 'RepCid' changed to 'RepCid_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, Variants;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  RepCidMajorVersion = 1;
  RepCidMinorVersion = 16;

  LIBID_RepCid: TGUID = '{2E6553EC-AA8B-40CC-AAB3-7C5314781D63}';

  IID__SessionRequest: TGUID = '{C0CCBC30-BCE7-396D-B2FE-4E12C2D5F6F6}';
  IID__iDCloudRequest: TGUID = '{B9F0D613-C813-3281-B928-7CA9851E3DEB}';
  IID__TemplateMergeRequest: TGUID = '{825098E8-CA3D-3254-ADA5-AF48B1A90A71}';
  IID__DayLightRequest: TGUID = '{D2B45AED-FDA6-3AB1-A084-E14A8724E32D}';
  IID__EmpregadorRequest: TGUID = '{3928D50D-DC11-3468-88F2-82EF5057271A}';
  IID__NetworkRequest: TGUID = '{1DDA8C19-9BD8-3ABC-945E-B0328B7B65D7}';
  IID__UserDeleteRequest: TGUID = '{44AFF39E-04B7-3C72-9DE8-BF4F849AE1A3}';
  IID__UserUpdateRequest: TGUID = '{0BFFB6B0-DC72-3B82-BF1C-B9CAD2AE1DC0}';
  IID__UserAddRequest: TGUID = '{1677B010-F804-301A-BA72-39FDDEF95317}';
  IID__UserRequest: TGUID = '{8ECB5046-7B96-316D-A97A-622F4FD4BB7F}';
  IID__DateTimeRequest: TGUID = '{965BBD9C-B02D-3978-B557-AF2517B38C0B}';
  IID__iDCloudResult: TGUID = '{C0BCD289-7965-3578-8EB1-D120B89ABB77}';
  IID__StatusResult: TGUID = '{415435DD-28A1-3954-802F-5B04689A931F}';
  IID__TemplateMergeResult: TGUID = '{64078EF7-92A2-37BF-8745-69C34630040F}';
  IID__TemplateResult: TGUID = '{C3C2EA9C-0CA6-3E5D-9656-E072ACE85161}';
  IID__NetworkResult: TGUID = '{057BE3A6-3F7D-3F61-ABE4-8AFB34EC7D71}';
  IID__DayLightResult: TGUID = '{711124FB-730B-36D3-8DC3-499AB74C2159}';
  IID__Date: TGUID = '{290B712F-C22E-394B-B43A-306E815A20AE}';
  IID__EmpregadorResult: TGUID = '{4D701A09-621B-3E5A-BD0B-4EF83F16C44A}';
  IID__Company: TGUID = '{F2C2BCA2-8014-3E82-B009-5321DAD6E7AB}';
  IID__ConnectRequest: TGUID = '{CD566B20-BD93-31AA-A222-F294AF683EC4}';
  IID__LogoutRequest: TGUID = '{82F657A3-ACF8-3BEB-B9DC-3DE5B2CAA914}';
  IID__ConnectResult: TGUID = '{D7445E82-A83B-389F-B7BC-120334D102A3}';
  IID__AboutResult: TGUID = '{67569347-DFB5-36AA-96F2-4A14EF7FEC9E}';
  IID__InfoResult: TGUID = '{E8CB14E7-122B-37D3-B068-B3F579E8CA2B}';
  IID__AFDRequest: TGUID = '{44E2C683-9742-3A0E-B775-8706D614685F}';
  IID__AFDResultLines: TGUID = '{AC2C5190-2236-337F-AD4D-1551CA5AD0EE}';
  IID__AFDResultString: TGUID = '{02C1C881-A0AE-3DEC-B474-196CCC6A73C3}';
  IID__DateTimeResult: TGUID = '{0BDA54C7-D94B-3B31-84FF-F065BF204195}';
  IID__UserResult: TGUID = '{E7F321AB-EBBE-3B6C-A285-85FD399D3EF0}';
  IID__User: TGUID = '{A1B15120-4911-3D5D-A793-09EAC5EE835E}';
  IID__SSLValidator: TGUID = '{BE6C0CDB-BCA0-315B-B171-0205E9FC4B83}';
  IID__RestJSON: TGUID = '{8A580534-635D-3432-BC5B-D83D2321C36F}';
  IID_IRepCid: TGUID = '{D2F17A98-059A-4AB3-B025-2A29845F0016}';
  CLASS_RepCid_: TGUID = '{52A5E378-4F45-42AC-93B1-2941BAEC4519}';
  IID_IRepCidUsb: TGUID = '{F2DA474B-1048-4E74-88F5-8CB1CA699783}';
  CLASS_RepCidUsb: TGUID = '{D4498B68-74D6-46BA-883A-0BD0C4ED9B1D}';
  CLASS_SessionRequest: TGUID = '{90C68148-78A2-36A8-9A83-7F25A06EFA61}';
  CLASS_iDCloudRequest: TGUID = '{544421E0-3B8C-3FE9-90B2-88BAD7F2BB9D}';
  CLASS_TemplateMergeRequest: TGUID = '{E4E7D63F-81DD-3BAA-89F9-CAF01A4AA7B6}';
  CLASS_DayLightRequest: TGUID = '{145104AE-E7D6-319F-99EB-1DBF58A52BE0}';
  CLASS_EmpregadorRequest: TGUID = '{910AA3AB-D8D0-3520-9BB2-48E31C5972B8}';
  CLASS_NetworkRequest: TGUID = '{DFC065FD-361E-3626-968E-F72320F02170}';
  CLASS_UserDeleteRequest: TGUID = '{16F6D1B3-F6B4-3D1D-9C8F-900E5DA5A328}';
  CLASS_UserUpdateRequest: TGUID = '{5ED598B8-9878-3F6F-99A3-B750FC9D874B}';
  CLASS_UserAddRequest: TGUID = '{183D57D3-DE29-3974-B185-AED547A26F96}';
  CLASS_UserRequest: TGUID = '{CB42A095-B8EA-3694-BBFF-890A27B015B5}';
  CLASS_DateTimeRequest: TGUID = '{426DCD1F-45F1-3BBE-8727-80CF7E7ADAB8}';
  CLASS_iDCloudResult: TGUID = '{E7C334A7-63C0-363B-9150-6168668214E7}';
  CLASS_StatusResult: TGUID = '{F4815DCF-DDA3-3086-8AA4-6AF61141F38B}';
  CLASS_TemplateMergeResult: TGUID = '{C4A6C82B-2F49-361F-80A7-C36A22F23BF9}';
  CLASS_TemplateResult: TGUID = '{D879FC9A-44EA-3EB9-B3A4-8CD48170CD43}';
  CLASS_NetworkResult: TGUID = '{75BDADCA-9735-33E5-9F83-CE2ED2542CAB}';
  CLASS_DayLightResult: TGUID = '{B78EA7EF-4D4A-3919-9A98-27F75B1A5158}';
  CLASS_Date: TGUID = '{FA5F39E6-2D4D-3B22-AE4E-239F47C5218A}';
  CLASS_EmpregadorResult: TGUID = '{FFB44EF9-DFCD-3074-A192-FDD8E3C803F3}';
  CLASS_Company: TGUID = '{8EF0BA54-3A7D-305B-8BDE-9C5A8789E684}';
  CLASS_ConnectRequest: TGUID = '{266D4EB0-0D14-3083-B374-B52A4FCFE6A8}';
  CLASS_LogoutRequest: TGUID = '{BA5B35C2-674C-3DA4-AB21-46249E04BEC6}';
  CLASS_ConnectResult: TGUID = '{0860DCA8-F8CD-3209-846D-D0966378E105}';
  CLASS_AboutResult: TGUID = '{CAC739DA-688C-31F4-909A-341A386A66D9}';
  CLASS_InfoResult: TGUID = '{BA14B5C4-0BDD-3D6E-8202-E9FD45E92971}';
  CLASS_AFDRequest: TGUID = '{65B3FC4D-B166-3CB1-BBF5-07D10C3BDCAA}';
  CLASS_AFDResultLines: TGUID = '{22359EED-5051-3621-997A-69C7E9DF8A81}';
  CLASS_AFDResultString: TGUID = '{E84441C7-5191-3CDB-8283-6E6F2DB53C0B}';
  CLASS_DateTimeResult: TGUID = '{708C061F-E2E9-38C7-9555-D183DB78BF8C}';
  CLASS_UserResult: TGUID = '{01F25F7D-B7C3-3AA6-97EE-8A296858A671}';
  CLASS_User: TGUID = '{70A99D0D-65AC-3DD7-A286-7D4ED0C8ADC1}';
  CLASS_SSLValidator: TGUID = '{D98413B6-C04F-3978-9FFD-C96444763EA0}';
  CLASS_RestJSON: TGUID = '{93B79AE4-2E76-3794-A7EE-4A886AB6F88B}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum ErrosRep
type
  ErrosRep = TOleEnum;
const
  ErrosRep_OK = $00000001;
  ErrosRep_ErroConexao = $00000002;
  ErrosRep_ErroAutenticacao = $00000003;
  ErrosRep_ErroNaoOcioso = $00000004;
  ErrosRep_ErroOutro = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  _SessionRequest = interface;
  _SessionRequestDisp = dispinterface;
  _iDCloudRequest = interface;
  _iDCloudRequestDisp = dispinterface;
  _TemplateMergeRequest = interface;
  _TemplateMergeRequestDisp = dispinterface;
  _DayLightRequest = interface;
  _DayLightRequestDisp = dispinterface;
  _EmpregadorRequest = interface;
  _EmpregadorRequestDisp = dispinterface;
  _NetworkRequest = interface;
  _NetworkRequestDisp = dispinterface;
  _UserDeleteRequest = interface;
  _UserDeleteRequestDisp = dispinterface;
  _UserUpdateRequest = interface;
  _UserUpdateRequestDisp = dispinterface;
  _UserAddRequest = interface;
  _UserAddRequestDisp = dispinterface;
  _UserRequest = interface;
  _UserRequestDisp = dispinterface;
  _DateTimeRequest = interface;
  _DateTimeRequestDisp = dispinterface;
  _iDCloudResult = interface;
  _iDCloudResultDisp = dispinterface;
  _StatusResult = interface;
  _StatusResultDisp = dispinterface;
  _TemplateMergeResult = interface;
  _TemplateMergeResultDisp = dispinterface;
  _TemplateResult = interface;
  _TemplateResultDisp = dispinterface;
  _NetworkResult = interface;
  _NetworkResultDisp = dispinterface;
  _DayLightResult = interface;
  _DayLightResultDisp = dispinterface;
  _Date = interface;
  _DateDisp = dispinterface;
  _EmpregadorResult = interface;
  _EmpregadorResultDisp = dispinterface;
  _Company = interface;
  _CompanyDisp = dispinterface;
  _ConnectRequest = interface;
  _ConnectRequestDisp = dispinterface;
  _LogoutRequest = interface;
  _LogoutRequestDisp = dispinterface;
  _ConnectResult = interface;
  _ConnectResultDisp = dispinterface;
  _AboutResult = interface;
  _AboutResultDisp = dispinterface;
  _InfoResult = interface;
  _InfoResultDisp = dispinterface;
  _AFDRequest = interface;
  _AFDRequestDisp = dispinterface;
  _AFDResultLines = interface;
  _AFDResultLinesDisp = dispinterface;
  _AFDResultString = interface;
  _AFDResultStringDisp = dispinterface;
  _DateTimeResult = interface;
  _DateTimeResultDisp = dispinterface;
  _UserResult = interface;
  _UserResultDisp = dispinterface;
  _User = interface;
  _UserDisp = dispinterface;
  _SSLValidator = interface;
  _SSLValidatorDisp = dispinterface;
  _RestJSON = interface;
  _RestJSONDisp = dispinterface;
  IRepCid = interface;
  IRepCidDisp = dispinterface;
  IRepCidUsb = interface;
  IRepCidUsbDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  RepCid_ = IRepCid;
  RepCidUsb = IRepCidUsb;
  SessionRequest = _SessionRequest;
  iDCloudRequest = _iDCloudRequest;
  TemplateMergeRequest = _TemplateMergeRequest;
  DayLightRequest = _DayLightRequest;
  EmpregadorRequest = _EmpregadorRequest;
  NetworkRequest = _NetworkRequest;
  UserDeleteRequest = _UserDeleteRequest;
  UserUpdateRequest = _UserUpdateRequest;
  UserAddRequest = _UserAddRequest;
  UserRequest = _UserRequest;
  DateTimeRequest = _DateTimeRequest;
  iDCloudResult = _iDCloudResult;
  StatusResult = _StatusResult;
  TemplateMergeResult = _TemplateMergeResult;
  TemplateResult = _TemplateResult;
  NetworkResult = _NetworkResult;
  DayLightResult = _DayLightResult;
  Date1 = _Date;
  EmpregadorResult = _EmpregadorResult;
  Company = _Company;
  ConnectRequest = _ConnectRequest;
  LogoutRequest = _LogoutRequest;
  ConnectResult = _ConnectResult;
  AboutResult = _AboutResult;
  InfoResult = _InfoResult;
  AFDRequest = _AFDRequest;
  AFDResultLines = _AFDResultLines;
  AFDResultString = _AFDResultString;
  DateTimeResult = _DateTimeResult;
  UserResult = _UserResult;
  User = _User;
  SSLValidator = _SSLValidator;
  RestJSON = _RestJSON;


// *********************************************************************//
// Interface: _SessionRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0CCBC30-BCE7-396D-B2FE-4E12C2D5F6F6}
// *********************************************************************//
  _SessionRequest = interface(IDispatch)
    ['{C0CCBC30-BCE7-396D-B2FE-4E12C2D5F6F6}']
  end;

// *********************************************************************//
// DispIntf:  _SessionRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0CCBC30-BCE7-396D-B2FE-4E12C2D5F6F6}
// *********************************************************************//
  _SessionRequestDisp = dispinterface
    ['{C0CCBC30-BCE7-396D-B2FE-4E12C2D5F6F6}']
  end;

// *********************************************************************//
// Interface: _iDCloudRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B9F0D613-C813-3281-B928-7CA9851E3DEB}
// *********************************************************************//
  _iDCloudRequest = interface(IDispatch)
    ['{B9F0D613-C813-3281-B928-7CA9851E3DEB}']
  end;

// *********************************************************************//
// DispIntf:  _iDCloudRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B9F0D613-C813-3281-B928-7CA9851E3DEB}
// *********************************************************************//
  _iDCloudRequestDisp = dispinterface
    ['{B9F0D613-C813-3281-B928-7CA9851E3DEB}']
  end;

// *********************************************************************//
// Interface: _TemplateMergeRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {825098E8-CA3D-3254-ADA5-AF48B1A90A71}
// *********************************************************************//
  _TemplateMergeRequest = interface(IDispatch)
    ['{825098E8-CA3D-3254-ADA5-AF48B1A90A71}']
  end;

// *********************************************************************//
// DispIntf:  _TemplateMergeRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {825098E8-CA3D-3254-ADA5-AF48B1A90A71}
// *********************************************************************//
  _TemplateMergeRequestDisp = dispinterface
    ['{825098E8-CA3D-3254-ADA5-AF48B1A90A71}']
  end;

// *********************************************************************//
// Interface: _DayLightRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D2B45AED-FDA6-3AB1-A084-E14A8724E32D}
// *********************************************************************//
  _DayLightRequest = interface(IDispatch)
    ['{D2B45AED-FDA6-3AB1-A084-E14A8724E32D}']
  end;

// *********************************************************************//
// DispIntf:  _DayLightRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D2B45AED-FDA6-3AB1-A084-E14A8724E32D}
// *********************************************************************//
  _DayLightRequestDisp = dispinterface
    ['{D2B45AED-FDA6-3AB1-A084-E14A8724E32D}']
  end;

// *********************************************************************//
// Interface: _EmpregadorRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3928D50D-DC11-3468-88F2-82EF5057271A}
// *********************************************************************//
  _EmpregadorRequest = interface(IDispatch)
    ['{3928D50D-DC11-3468-88F2-82EF5057271A}']
  end;

// *********************************************************************//
// DispIntf:  _EmpregadorRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3928D50D-DC11-3468-88F2-82EF5057271A}
// *********************************************************************//
  _EmpregadorRequestDisp = dispinterface
    ['{3928D50D-DC11-3468-88F2-82EF5057271A}']
  end;

// *********************************************************************//
// Interface: _NetworkRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1DDA8C19-9BD8-3ABC-945E-B0328B7B65D7}
// *********************************************************************//
  _NetworkRequest = interface(IDispatch)
    ['{1DDA8C19-9BD8-3ABC-945E-B0328B7B65D7}']
  end;

// *********************************************************************//
// DispIntf:  _NetworkRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1DDA8C19-9BD8-3ABC-945E-B0328B7B65D7}
// *********************************************************************//
  _NetworkRequestDisp = dispinterface
    ['{1DDA8C19-9BD8-3ABC-945E-B0328B7B65D7}']
  end;

// *********************************************************************//
// Interface: _UserDeleteRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44AFF39E-04B7-3C72-9DE8-BF4F849AE1A3}
// *********************************************************************//
  _UserDeleteRequest = interface(IDispatch)
    ['{44AFF39E-04B7-3C72-9DE8-BF4F849AE1A3}']
  end;

// *********************************************************************//
// DispIntf:  _UserDeleteRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44AFF39E-04B7-3C72-9DE8-BF4F849AE1A3}
// *********************************************************************//
  _UserDeleteRequestDisp = dispinterface
    ['{44AFF39E-04B7-3C72-9DE8-BF4F849AE1A3}']
  end;

// *********************************************************************//
// Interface: _UserUpdateRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0BFFB6B0-DC72-3B82-BF1C-B9CAD2AE1DC0}
// *********************************************************************//
  _UserUpdateRequest = interface(IDispatch)
    ['{0BFFB6B0-DC72-3B82-BF1C-B9CAD2AE1DC0}']
  end;

// *********************************************************************//
// DispIntf:  _UserUpdateRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0BFFB6B0-DC72-3B82-BF1C-B9CAD2AE1DC0}
// *********************************************************************//
  _UserUpdateRequestDisp = dispinterface
    ['{0BFFB6B0-DC72-3B82-BF1C-B9CAD2AE1DC0}']
  end;

// *********************************************************************//
// Interface: _UserAddRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1677B010-F804-301A-BA72-39FDDEF95317}
// *********************************************************************//
  _UserAddRequest = interface(IDispatch)
    ['{1677B010-F804-301A-BA72-39FDDEF95317}']
  end;

// *********************************************************************//
// DispIntf:  _UserAddRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1677B010-F804-301A-BA72-39FDDEF95317}
// *********************************************************************//
  _UserAddRequestDisp = dispinterface
    ['{1677B010-F804-301A-BA72-39FDDEF95317}']
  end;

// *********************************************************************//
// Interface: _UserRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8ECB5046-7B96-316D-A97A-622F4FD4BB7F}
// *********************************************************************//
  _UserRequest = interface(IDispatch)
    ['{8ECB5046-7B96-316D-A97A-622F4FD4BB7F}']
  end;

// *********************************************************************//
// DispIntf:  _UserRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8ECB5046-7B96-316D-A97A-622F4FD4BB7F}
// *********************************************************************//
  _UserRequestDisp = dispinterface
    ['{8ECB5046-7B96-316D-A97A-622F4FD4BB7F}']
  end;

// *********************************************************************//
// Interface: _DateTimeRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {965BBD9C-B02D-3978-B557-AF2517B38C0B}
// *********************************************************************//
  _DateTimeRequest = interface(IDispatch)
    ['{965BBD9C-B02D-3978-B557-AF2517B38C0B}']
  end;

// *********************************************************************//
// DispIntf:  _DateTimeRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {965BBD9C-B02D-3978-B557-AF2517B38C0B}
// *********************************************************************//
  _DateTimeRequestDisp = dispinterface
    ['{965BBD9C-B02D-3978-B557-AF2517B38C0B}']
  end;

// *********************************************************************//
// Interface: _iDCloudResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0BCD289-7965-3578-8EB1-D120B89ABB77}
// *********************************************************************//
  _iDCloudResult = interface(IDispatch)
    ['{C0BCD289-7965-3578-8EB1-D120B89ABB77}']
  end;

// *********************************************************************//
// DispIntf:  _iDCloudResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0BCD289-7965-3578-8EB1-D120B89ABB77}
// *********************************************************************//
  _iDCloudResultDisp = dispinterface
    ['{C0BCD289-7965-3578-8EB1-D120B89ABB77}']
  end;

// *********************************************************************//
// Interface: _StatusResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {415435DD-28A1-3954-802F-5B04689A931F}
// *********************************************************************//
  _StatusResult = interface(IDispatch)
    ['{415435DD-28A1-3954-802F-5B04689A931F}']
  end;

// *********************************************************************//
// DispIntf:  _StatusResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {415435DD-28A1-3954-802F-5B04689A931F}
// *********************************************************************//
  _StatusResultDisp = dispinterface
    ['{415435DD-28A1-3954-802F-5B04689A931F}']
  end;

// *********************************************************************//
// Interface: _TemplateMergeResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {64078EF7-92A2-37BF-8745-69C34630040F}
// *********************************************************************//
  _TemplateMergeResult = interface(IDispatch)
    ['{64078EF7-92A2-37BF-8745-69C34630040F}']
  end;

// *********************************************************************//
// DispIntf:  _TemplateMergeResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {64078EF7-92A2-37BF-8745-69C34630040F}
// *********************************************************************//
  _TemplateMergeResultDisp = dispinterface
    ['{64078EF7-92A2-37BF-8745-69C34630040F}']
  end;

// *********************************************************************//
// Interface: _TemplateResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C3C2EA9C-0CA6-3E5D-9656-E072ACE85161}
// *********************************************************************//
  _TemplateResult = interface(IDispatch)
    ['{C3C2EA9C-0CA6-3E5D-9656-E072ACE85161}']
  end;

// *********************************************************************//
// DispIntf:  _TemplateResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C3C2EA9C-0CA6-3E5D-9656-E072ACE85161}
// *********************************************************************//
  _TemplateResultDisp = dispinterface
    ['{C3C2EA9C-0CA6-3E5D-9656-E072ACE85161}']
  end;

// *********************************************************************//
// Interface: _NetworkResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {057BE3A6-3F7D-3F61-ABE4-8AFB34EC7D71}
// *********************************************************************//
  _NetworkResult = interface(IDispatch)
    ['{057BE3A6-3F7D-3F61-ABE4-8AFB34EC7D71}']
  end;

// *********************************************************************//
// DispIntf:  _NetworkResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {057BE3A6-3F7D-3F61-ABE4-8AFB34EC7D71}
// *********************************************************************//
  _NetworkResultDisp = dispinterface
    ['{057BE3A6-3F7D-3F61-ABE4-8AFB34EC7D71}']
  end;

// *********************************************************************//
// Interface: _DayLightResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {711124FB-730B-36D3-8DC3-499AB74C2159}
// *********************************************************************//
  _DayLightResult = interface(IDispatch)
    ['{711124FB-730B-36D3-8DC3-499AB74C2159}']
  end;

// *********************************************************************//
// DispIntf:  _DayLightResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {711124FB-730B-36D3-8DC3-499AB74C2159}
// *********************************************************************//
  _DayLightResultDisp = dispinterface
    ['{711124FB-730B-36D3-8DC3-499AB74C2159}']
  end;

// *********************************************************************//
// Interface: _Date
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {290B712F-C22E-394B-B43A-306E815A20AE}
// *********************************************************************//
  _Date = interface(IDispatch)
    ['{290B712F-C22E-394B-B43A-306E815A20AE}']
  end;

// *********************************************************************//
// DispIntf:  _DateDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {290B712F-C22E-394B-B43A-306E815A20AE}
// *********************************************************************//
  _DateDisp = dispinterface
    ['{290B712F-C22E-394B-B43A-306E815A20AE}']
  end;

// *********************************************************************//
// Interface: _EmpregadorResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4D701A09-621B-3E5A-BD0B-4EF83F16C44A}
// *********************************************************************//
  _EmpregadorResult = interface(IDispatch)
    ['{4D701A09-621B-3E5A-BD0B-4EF83F16C44A}']
  end;

// *********************************************************************//
// DispIntf:  _EmpregadorResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4D701A09-621B-3E5A-BD0B-4EF83F16C44A}
// *********************************************************************//
  _EmpregadorResultDisp = dispinterface
    ['{4D701A09-621B-3E5A-BD0B-4EF83F16C44A}']
  end;

// *********************************************************************//
// Interface: _Company
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F2C2BCA2-8014-3E82-B009-5321DAD6E7AB}
// *********************************************************************//
  _Company = interface(IDispatch)
    ['{F2C2BCA2-8014-3E82-B009-5321DAD6E7AB}']
  end;

// *********************************************************************//
// DispIntf:  _CompanyDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F2C2BCA2-8014-3E82-B009-5321DAD6E7AB}
// *********************************************************************//
  _CompanyDisp = dispinterface
    ['{F2C2BCA2-8014-3E82-B009-5321DAD6E7AB}']
  end;

// *********************************************************************//
// Interface: _ConnectRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CD566B20-BD93-31AA-A222-F294AF683EC4}
// *********************************************************************//
  _ConnectRequest = interface(IDispatch)
    ['{CD566B20-BD93-31AA-A222-F294AF683EC4}']
  end;

// *********************************************************************//
// DispIntf:  _ConnectRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CD566B20-BD93-31AA-A222-F294AF683EC4}
// *********************************************************************//
  _ConnectRequestDisp = dispinterface
    ['{CD566B20-BD93-31AA-A222-F294AF683EC4}']
  end;

// *********************************************************************//
// Interface: _LogoutRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {82F657A3-ACF8-3BEB-B9DC-3DE5B2CAA914}
// *********************************************************************//
  _LogoutRequest = interface(IDispatch)
    ['{82F657A3-ACF8-3BEB-B9DC-3DE5B2CAA914}']
  end;

// *********************************************************************//
// DispIntf:  _LogoutRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {82F657A3-ACF8-3BEB-B9DC-3DE5B2CAA914}
// *********************************************************************//
  _LogoutRequestDisp = dispinterface
    ['{82F657A3-ACF8-3BEB-B9DC-3DE5B2CAA914}']
  end;

// *********************************************************************//
// Interface: _ConnectResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D7445E82-A83B-389F-B7BC-120334D102A3}
// *********************************************************************//
  _ConnectResult = interface(IDispatch)
    ['{D7445E82-A83B-389F-B7BC-120334D102A3}']
  end;

// *********************************************************************//
// DispIntf:  _ConnectResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D7445E82-A83B-389F-B7BC-120334D102A3}
// *********************************************************************//
  _ConnectResultDisp = dispinterface
    ['{D7445E82-A83B-389F-B7BC-120334D102A3}']
  end;

// *********************************************************************//
// Interface: _AboutResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {67569347-DFB5-36AA-96F2-4A14EF7FEC9E}
// *********************************************************************//
  _AboutResult = interface(IDispatch)
    ['{67569347-DFB5-36AA-96F2-4A14EF7FEC9E}']
  end;

// *********************************************************************//
// DispIntf:  _AboutResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {67569347-DFB5-36AA-96F2-4A14EF7FEC9E}
// *********************************************************************//
  _AboutResultDisp = dispinterface
    ['{67569347-DFB5-36AA-96F2-4A14EF7FEC9E}']
  end;

// *********************************************************************//
// Interface: _InfoResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E8CB14E7-122B-37D3-B068-B3F579E8CA2B}
// *********************************************************************//
  _InfoResult = interface(IDispatch)
    ['{E8CB14E7-122B-37D3-B068-B3F579E8CA2B}']
  end;

// *********************************************************************//
// DispIntf:  _InfoResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E8CB14E7-122B-37D3-B068-B3F579E8CA2B}
// *********************************************************************//
  _InfoResultDisp = dispinterface
    ['{E8CB14E7-122B-37D3-B068-B3F579E8CA2B}']
  end;

// *********************************************************************//
// Interface: _AFDRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44E2C683-9742-3A0E-B775-8706D614685F}
// *********************************************************************//
  _AFDRequest = interface(IDispatch)
    ['{44E2C683-9742-3A0E-B775-8706D614685F}']
  end;

// *********************************************************************//
// DispIntf:  _AFDRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44E2C683-9742-3A0E-B775-8706D614685F}
// *********************************************************************//
  _AFDRequestDisp = dispinterface
    ['{44E2C683-9742-3A0E-B775-8706D614685F}']
  end;

// *********************************************************************//
// Interface: _AFDResultLines
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AC2C5190-2236-337F-AD4D-1551CA5AD0EE}
// *********************************************************************//
  _AFDResultLines = interface(IDispatch)
    ['{AC2C5190-2236-337F-AD4D-1551CA5AD0EE}']
  end;

// *********************************************************************//
// DispIntf:  _AFDResultLinesDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AC2C5190-2236-337F-AD4D-1551CA5AD0EE}
// *********************************************************************//
  _AFDResultLinesDisp = dispinterface
    ['{AC2C5190-2236-337F-AD4D-1551CA5AD0EE}']
  end;

// *********************************************************************//
// Interface: _AFDResultString
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {02C1C881-A0AE-3DEC-B474-196CCC6A73C3}
// *********************************************************************//
  _AFDResultString = interface(IDispatch)
    ['{02C1C881-A0AE-3DEC-B474-196CCC6A73C3}']
  end;

// *********************************************************************//
// DispIntf:  _AFDResultStringDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {02C1C881-A0AE-3DEC-B474-196CCC6A73C3}
// *********************************************************************//
  _AFDResultStringDisp = dispinterface
    ['{02C1C881-A0AE-3DEC-B474-196CCC6A73C3}']
  end;

// *********************************************************************//
// Interface: _DateTimeResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0BDA54C7-D94B-3B31-84FF-F065BF204195}
// *********************************************************************//
  _DateTimeResult = interface(IDispatch)
    ['{0BDA54C7-D94B-3B31-84FF-F065BF204195}']
  end;

// *********************************************************************//
// DispIntf:  _DateTimeResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0BDA54C7-D94B-3B31-84FF-F065BF204195}
// *********************************************************************//
  _DateTimeResultDisp = dispinterface
    ['{0BDA54C7-D94B-3B31-84FF-F065BF204195}']
  end;

// *********************************************************************//
// Interface: _UserResult
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E7F321AB-EBBE-3B6C-A285-85FD399D3EF0}
// *********************************************************************//
  _UserResult = interface(IDispatch)
    ['{E7F321AB-EBBE-3B6C-A285-85FD399D3EF0}']
  end;

// *********************************************************************//
// DispIntf:  _UserResultDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E7F321AB-EBBE-3B6C-A285-85FD399D3EF0}
// *********************************************************************//
  _UserResultDisp = dispinterface
    ['{E7F321AB-EBBE-3B6C-A285-85FD399D3EF0}']
  end;

// *********************************************************************//
// Interface: _User
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A1B15120-4911-3D5D-A793-09EAC5EE835E}
// *********************************************************************//
  _User = interface(IDispatch)
    ['{A1B15120-4911-3D5D-A793-09EAC5EE835E}']
  end;

// *********************************************************************//
// DispIntf:  _UserDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A1B15120-4911-3D5D-A793-09EAC5EE835E}
// *********************************************************************//
  _UserDisp = dispinterface
    ['{A1B15120-4911-3D5D-A793-09EAC5EE835E}']
  end;

// *********************************************************************//
// Interface: _SSLValidator
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BE6C0CDB-BCA0-315B-B171-0205E9FC4B83}
// *********************************************************************//
  _SSLValidator = interface(IDispatch)
    ['{BE6C0CDB-BCA0-315B-B171-0205E9FC4B83}']
  end;

// *********************************************************************//
// DispIntf:  _SSLValidatorDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BE6C0CDB-BCA0-315B-B171-0205E9FC4B83}
// *********************************************************************//
  _SSLValidatorDisp = dispinterface
    ['{BE6C0CDB-BCA0-315B-B171-0205E9FC4B83}']
  end;

// *********************************************************************//
// Interface: _RestJSON
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8A580534-635D-3432-BC5B-D83D2321C36F}
// *********************************************************************//
  _RestJSON = interface(IDispatch)
    ['{8A580534-635D-3432-BC5B-D83D2321C36F}']
  end;

// *********************************************************************//
// DispIntf:  _RestJSONDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8A580534-635D-3432-BC5B-D83D2321C36F}
// *********************************************************************//
  _RestJSONDisp = dispinterface
    ['{8A580534-635D-3432-BC5B-D83D2321C36F}']
  end;

// *********************************************************************//
// Interface: IRepCid
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2F17A98-059A-4AB3-B025-2A29845F0016}
// *********************************************************************//
  IRepCid = interface(IDispatch)
    ['{D2F17A98-059A-4AB3-B025-2A29845F0016}']
    function LerEmpregador(out documento: WideString; out tipoDocumento: Integer;
                           out cei: WideString; out razaoSocial: WideString;
                           out endereco: WideString): WordBool; safecall;
    function iDClass_LerEmpregador(out documento: WideString; out tipoDocumento: Integer;
                                   out cei: WideString; out razaoSocial: WideString;
                                   out endereco: WideString; out cpf: WideString): WordBool; safecall;
    function GravarEmpregador(const documento: WideString; tipoDocumento: Integer;
                              const cei: WideString; const razaoSocial: WideString;
                              const endereco: WideString; out gravou: WordBool): WordBool; safecall;
    function iDClass_GravarEmpregador(const documento: WideString; tipoDocumento: Integer;
                                      const cei: WideString; const razaoSocial: WideString;
                                      const endereco: WideString; const cpf: WideString;
                                      out gravou: WordBool): WordBool; safecall;
    function ApagarTemplatesUsuario(pis: Int64; out apagou: WordBool): WordBool; safecall;
    function ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool; safecall;
    function GravarTemplateUsuario(pis: Int64; template_bin: PSafeArray; out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuario_vb6(const pis: WideString; template_bin: PSafeArray;
                                       out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuarioStr(pis: Int64; const template_base64: WideString;
                                      out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuarioStr_vb6(const pis: WideString; const template_base64: WideString;
                                          out gravou: WordBool): WordBool; safecall;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; safecall;
    function CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool; safecall;
    function LerTemplate(out template_bin: PSafeArray): WordBool; safecall;
    function LerTemplateStr(out template_base64: WideString): WordBool; safecall;
    function ExtractTemplate(bytes: PSafeArray; width: Integer; height: Integer;
                             out template_bin: PSafeArray): WordBool; safecall;
    function JoinTemplates(template1_bin: PSafeArray; template2_bin: PSafeArray;
                           template3_bin: PSafeArray; out resultado_bin: PSafeArray): WordBool; safecall;
    function LerConfigRede(out ip: WideString; out netmask: WideString; out gateway: WideString;
                           out porta: Word): WordBool; safecall;
    function LerConfigRede_vb6(out ip: WideString; out netmask: WideString;
                               out gateway: WideString; out porta: Integer): WordBool; safecall;
    function GravarConfigRede(const ip: WideString; const netmask: WideString;
                              const gateway: WideString; porta: Word; out gravou: WordBool): WordBool; safecall;
    function GravarConfigRede_vb6(const ip: WideString; const netmask: WideString;
                                  const gateway: WideString; porta: Integer; out gravou: WordBool): WordBool; safecall;
    function LerInfo(out sn: WideString; out tam_bobina: LongWord; out restante_bobina: LongWord;
                     out uptime: LongWord; out cortes: LongWord; out papel_acumulado: LongWord;
                     out nsr_atual: LongWord): WordBool; safecall;
    function LerInfo_vb6(out sn: WideString; out tam_bobina: WideString;
                         out restante_bobina: WideString; out uptime: WideString;
                         out cortes: WideString; out papel_acumulado: WideString;
                         out nsr_atual: WideString): WordBool; safecall;
    function LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; out hora: Integer;
                         out minuto: Integer; out segundo: Integer): WordBool; safecall;
    function GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer;
                            minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool; safecall;
    function LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer;
                             out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool; safecall;
    function GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer;
                                fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool; safecall;
    function ProcurarREPs: WideString; safecall;
    function CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool; safecall;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: Integer;
                        out senha: WideString; out barras: WideString; out rfid: Integer;
                        out privilegios: Integer; out ndig: Integer): WordBool; safecall;
    function LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer;
                            out senha: WideString; out barras: WideString; out rfid: Integer;
                            out privilegios: Integer; out ndig: Integer): WordBool; safecall;
    function iDClass_LerUsuario(out pis: Int64; out nome: WideString; out matricula: Int64;
                                out codigo: Integer; out senha: WideString; out barras: WideString;
                                out rfid: Integer; out privilegios: Integer;
                                out templates: PSafeArray): WordBool; safecall;
    function LerDadosUsuario(pis: Int64; out nome: WideString; out codigo: Integer;
                             out senha: WideString; out barras: WideString; out rfid: Integer;
                             out privilegios: Integer): WordBool; safecall;
    function LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; out codigo: Integer;
                                 out senha: WideString; out barras: WideString; out rfid: Integer;
                                 out privilegios: Integer): WordBool; safecall;
    function iDClass_LerDadosUsuario(pis: Int64; out nome: WideString; out matricula: Int64;
                                     out codigo: Integer; out senha: WideString;
                                     out barras: WideString; out rfid: Integer;
                                     out privilegios: Integer; out templates: PSafeArray): WordBool; safecall;
    function GravarUsuario(pis: Int64; const nome: WideString; codigo: Integer;
                           const senha: WideString; const barras: WideString; rfid: Integer;
                           privilegios: Integer; out gravou: WordBool): WordBool; safecall;
    function GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer;
                               const senha: WideString; const barras: WideString; rfid: Integer;
                               privilegios: Integer; out gravou: WordBool): WordBool; safecall;
    function iDClass_GravarUsuario(pis: Int64; const nome: WideString; matricula: Int64;
                                   codigo: Integer; const senha: WideString;
                                   const barras: WideString; rfid: Integer; privilegios: Integer;
                                   templates: PSafeArray; out gravou: WordBool): WordBool; safecall;
    function RemoverUsuario(pis: Int64; out removeu: WordBool): WordBool; safecall;
    function RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool; safecall;
    function ApagarAdmins(out ok: WordBool): WordBool; safecall;
    function Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep; safecall;
    function Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep; safecall;
    function iDClass_Conectar(const ip: WideString; const cLogin: WideString;
                              const cSenha: WideString): ErrosRep; safecall;
    procedure Desconectar; safecall;
    function GetModeloVersao(out modelo: WideString): WordBool; safecall;
    function GetLastLog(out log: WideString): WordBool; safecall;
    function BuscarAFD(nsr: Integer): WordBool; safecall;
    function LerAFD(out linha: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRepCidDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2F17A98-059A-4AB3-B025-2A29845F0016}
// *********************************************************************//
  IRepCidDisp = dispinterface
    ['{D2F17A98-059A-4AB3-B025-2A29845F0016}']
    function LerEmpregador(out documento: WideString; out tipoDocumento: Integer;
                           out cei: WideString; out razaoSocial: WideString;
                           out endereco: WideString): WordBool; dispid 1610743808;
    function iDClass_LerEmpregador(out documento: WideString; out tipoDocumento: Integer;
                                   out cei: WideString; out razaoSocial: WideString;
                                   out endereco: WideString; out cpf: WideString): WordBool; dispid 1610743809;
    function GravarEmpregador(const documento: WideString; tipoDocumento: Integer;
                              const cei: WideString; const razaoSocial: WideString;
                              const endereco: WideString; out gravou: WordBool): WordBool; dispid 1610743810;
    function iDClass_GravarEmpregador(const documento: WideString; tipoDocumento: Integer;
                                      const cei: WideString; const razaoSocial: WideString;
                                      const endereco: WideString; const cpf: WideString;
                                      out gravou: WordBool): WordBool; dispid 1610743811;
    function ApagarTemplatesUsuario(pis: {??Int64}OleVariant; out apagou: WordBool): WordBool; dispid 1610743812;
    function ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool; dispid 1610743813;
    function GravarTemplateUsuario(pis: {??Int64}OleVariant;
                                   template_bin: {??PSafeArray}OleVariant; out gravou: WordBool): WordBool; dispid 1610743814;
    function GravarTemplateUsuario_vb6(const pis: WideString;
                                       template_bin: {??PSafeArray}OleVariant; out gravou: WordBool): WordBool; dispid 1610743815;
    function GravarTemplateUsuarioStr(pis: {??Int64}OleVariant; const template_base64: WideString;
                                      out gravou: WordBool): WordBool; dispid 1610743816;
    function GravarTemplateUsuarioStr_vb6(const pis: WideString; const template_base64: WideString;
                                          out gravou: WordBool): WordBool; dispid 1610743817;
    function CarregarTemplatesUsuario(pis: {??Int64}OleVariant; out num_templates: Integer): WordBool; dispid 1610743818;
    function CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool; dispid 1610743819;
    function LerTemplate(out template_bin: {??PSafeArray}OleVariant): WordBool; dispid 1610743820;
    function LerTemplateStr(out template_base64: WideString): WordBool; dispid 1610743821;
    function ExtractTemplate(bytes: {??PSafeArray}OleVariant; width: Integer; height: Integer;
                             out template_bin: {??PSafeArray}OleVariant): WordBool; dispid 1610743822;
    function JoinTemplates(template1_bin: {??PSafeArray}OleVariant;
                           template2_bin: {??PSafeArray}OleVariant;
                           template3_bin: {??PSafeArray}OleVariant;
                           out resultado_bin: {??PSafeArray}OleVariant): WordBool; dispid 1610743823;
    function LerConfigRede(out ip: WideString; out netmask: WideString; out gateway: WideString;
                           out porta: {??Word}OleVariant): WordBool; dispid 1610743824;
    function LerConfigRede_vb6(out ip: WideString; out netmask: WideString;
                               out gateway: WideString; out porta: Integer): WordBool; dispid 1610743825;
    function GravarConfigRede(const ip: WideString; const netmask: WideString;
                              const gateway: WideString; porta: {??Word}OleVariant;
                              out gravou: WordBool): WordBool; dispid 1610743826;
    function GravarConfigRede_vb6(const ip: WideString; const netmask: WideString;
                                  const gateway: WideString; porta: Integer; out gravou: WordBool): WordBool; dispid 1610743827;
    function LerInfo(out sn: WideString; out tam_bobina: LongWord; out restante_bobina: LongWord;
                     out uptime: LongWord; out cortes: LongWord; out papel_acumulado: LongWord;
                     out nsr_atual: LongWord): WordBool; dispid 1610743828;
    function LerInfo_vb6(out sn: WideString; out tam_bobina: WideString;
                         out restante_bobina: WideString; out uptime: WideString;
                         out cortes: WideString; out papel_acumulado: WideString;
                         out nsr_atual: WideString): WordBool; dispid 1610743829;
    function LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; out hora: Integer;
                         out minuto: Integer; out segundo: Integer): WordBool; dispid 1610743830;
    function GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer;
                            minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool; dispid 1610743831;
    function LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer;
                             out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool; dispid 1610743832;
    function GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer;
                                fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool; dispid 1610743833;
    function ProcurarREPs: WideString; dispid 1610743834;
    function CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool; dispid 1610743835;
    function LerUsuario(out pis: {??Int64}OleVariant; out nome: WideString; out codigo: Integer;
                        out senha: WideString; out barras: WideString; out rfid: Integer;
                        out privilegios: Integer; out ndig: Integer): WordBool; dispid 1610743836;
    function LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer;
                            out senha: WideString; out barras: WideString; out rfid: Integer;
                            out privilegios: Integer; out ndig: Integer): WordBool; dispid 1610743837;
    function iDClass_LerUsuario(out pis: {??Int64}OleVariant; out nome: WideString;
                                out matricula: {??Int64}OleVariant; out codigo: Integer;
                                out senha: WideString; out barras: WideString; out rfid: Integer;
                                out privilegios: Integer; out templates: {??PSafeArray}OleVariant): WordBool; dispid 1610743838;
    function LerDadosUsuario(pis: {??Int64}OleVariant; out nome: WideString; out codigo: Integer;
                             out senha: WideString; out barras: WideString; out rfid: Integer;
                             out privilegios: Integer): WordBool; dispid 1610743839;
    function LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; out codigo: Integer;
                                 out senha: WideString; out barras: WideString; out rfid: Integer;
                                 out privilegios: Integer): WordBool; dispid 1610743840;
    function iDClass_LerDadosUsuario(pis: {??Int64}OleVariant; out nome: WideString;
                                     out matricula: {??Int64}OleVariant; out codigo: Integer;
                                     out senha: WideString; out barras: WideString;
                                     out rfid: Integer; out privilegios: Integer;
                                     out templates: {??PSafeArray}OleVariant): WordBool; dispid 1610743841;
    function GravarUsuario(pis: {??Int64}OleVariant; const nome: WideString; codigo: Integer;
                           const senha: WideString; const barras: WideString; rfid: Integer;
                           privilegios: Integer; out gravou: WordBool): WordBool; dispid 1610743842;
    function GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer;
                               const senha: WideString; const barras: WideString; rfid: Integer;
                               privilegios: Integer; out gravou: WordBool): WordBool; dispid 1610743843;
    function iDClass_GravarUsuario(pis: {??Int64}OleVariant; const nome: WideString;
                                   matricula: {??Int64}OleVariant; codigo: Integer;
                                   const senha: WideString; const barras: WideString;
                                   rfid: Integer; privilegios: Integer;
                                   templates: {??PSafeArray}OleVariant; out gravou: WordBool): WordBool; dispid 1610743844;
    function RemoverUsuario(pis: {??Int64}OleVariant; out removeu: WordBool): WordBool; dispid 1610743845;
    function RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool; dispid 1610743846;
    function ApagarAdmins(out ok: WordBool): WordBool; dispid 1610743847;
    function Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep; dispid 1610743848;
    function Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep; dispid 1610743849;
    function iDClass_Conectar(const ip: WideString; const cLogin: WideString;
                              const cSenha: WideString): ErrosRep; dispid 1610743850;
    procedure Desconectar; dispid 1610743851;
    function GetModeloVersao(out modelo: WideString): WordBool; dispid 1610743852;
    function GetLastLog(out log: WideString): WordBool; dispid 1610743853;
    function BuscarAFD(nsr: Integer): WordBool; dispid 1610743854;
    function LerAFD(out linha: WideString): WordBool; dispid 1610743855;
  end;

// *********************************************************************//
// Interface: IRepCidUsb
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2DA474B-1048-4E74-88F5-8CB1CA699783}
// *********************************************************************//
  IRepCidUsb = interface(IDispatch)
    ['{F2DA474B-1048-4E74-88F5-8CB1CA699783}']
    function GetLastError: WideString; safecall;
    function CarregarUsuarios(const fileNameUsuarios: WideString;
                              const fileNameDigitais: WideString; out numUsrs: Integer;
                              out leuDigitais: WordBool): WordBool; safecall;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: LongWord;
                        out senha: WideString; out barras: WideString; out rfid: LongWord;
                        out privilegios: Integer; out num_templates: Integer): WordBool; safecall;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; safecall;
    function LerTemplate(out template_bin: PSafeArray): WordBool; safecall;
    function LerTemplateStr(out template_base64: WideString): WordBool; safecall;
    procedure IniciaGravacao; safecall;
    function AdicionarUsuario(pis: Int64; const nome: WideString; codigo: LongWord;
                              const senha: WideString; const barras: WideString; rfid: LongWord;
                              privilegios: Integer): WordBool; safecall;
    function AdicionarTemplate(pis: Int64; template_bin: PSafeArray): WordBool; safecall;
    function AdicionarTemplateStr(pis: Int64; const template_base64: WideString): WordBool; safecall;
    function FinalizarGravacao(const fileNameUsuarios: WideString;
                               const fileNameDigitais: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRepCidUsbDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2DA474B-1048-4E74-88F5-8CB1CA699783}
// *********************************************************************//
  IRepCidUsbDisp = dispinterface
    ['{F2DA474B-1048-4E74-88F5-8CB1CA699783}']
    function GetLastError: WideString; dispid 1610743808;
    function CarregarUsuarios(const fileNameUsuarios: WideString;
                              const fileNameDigitais: WideString; out numUsrs: Integer;
                              out leuDigitais: WordBool): WordBool; dispid 1610743809;
    function LerUsuario(out pis: {??Int64}OleVariant; out nome: WideString; out codigo: LongWord;
                        out senha: WideString; out barras: WideString; out rfid: LongWord;
                        out privilegios: Integer; out num_templates: Integer): WordBool; dispid 1610743810;
    function CarregarTemplatesUsuario(pis: {??Int64}OleVariant; out num_templates: Integer): WordBool; dispid 1610743811;
    function LerTemplate(out template_bin: {??PSafeArray}OleVariant): WordBool; dispid 1610743812;
    function LerTemplateStr(out template_base64: WideString): WordBool; dispid 1610743813;
    procedure IniciaGravacao; dispid 1610743814;
    function AdicionarUsuario(pis: {??Int64}OleVariant; const nome: WideString; codigo: LongWord;
                              const senha: WideString; const barras: WideString; rfid: LongWord;
                              privilegios: Integer): WordBool; dispid 1610743815;
    function AdicionarTemplate(pis: {??Int64}OleVariant; template_bin: {??PSafeArray}OleVariant): WordBool; dispid 1610743816;
    function AdicionarTemplateStr(pis: {??Int64}OleVariant; const template_base64: WideString): WordBool; dispid 1610743817;
    function FinalizarGravacao(const fileNameUsuarios: WideString;
                               const fileNameDigitais: WideString): WordBool; dispid 1610743818;
  end;

// *********************************************************************//
// The Class CoRepCid_ provides a Create and CreateRemote method to
// create instances of the default interface IRepCid exposed by
// the CoClass RepCid_. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRepCid_ = class
    class function Create: IRepCid;
    class function CreateRemote(const MachineName: string): IRepCid;
  end;

// *********************************************************************//
// The Class CoRepCidUsb provides a Create and CreateRemote method to
// create instances of the default interface IRepCidUsb exposed by
// the CoClass RepCidUsb. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRepCidUsb = class
    class function Create: IRepCidUsb;
    class function CreateRemote(const MachineName: string): IRepCidUsb;
  end;

// *********************************************************************//
// The Class CoSessionRequest provides a Create and CreateRemote method to
// create instances of the default interface _SessionRequest exposed by
// the CoClass SessionRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSessionRequest = class
    class function Create: _SessionRequest;
    class function CreateRemote(const MachineName: string): _SessionRequest;
  end;

// *********************************************************************//
// The Class CoiDCloudRequest provides a Create and CreateRemote method to
// create instances of the default interface _iDCloudRequest exposed by
// the CoClass iDCloudRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoiDCloudRequest = class
    class function Create: _iDCloudRequest;
    class function CreateRemote(const MachineName: string): _iDCloudRequest;
  end;

// *********************************************************************//
// The Class CoTemplateMergeRequest provides a Create and CreateRemote method to
// create instances of the default interface _TemplateMergeRequest exposed by
// the CoClass TemplateMergeRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoTemplateMergeRequest = class
    class function Create: _TemplateMergeRequest;
    class function CreateRemote(const MachineName: string): _TemplateMergeRequest;
  end;

// *********************************************************************//
// The Class CoDayLightRequest provides a Create and CreateRemote method to
// create instances of the default interface _DayLightRequest exposed by
// the CoClass DayLightRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDayLightRequest = class
    class function Create: _DayLightRequest;
    class function CreateRemote(const MachineName: string): _DayLightRequest;
  end;

// *********************************************************************//
// The Class CoEmpregadorRequest provides a Create and CreateRemote method to
// create instances of the default interface _EmpregadorRequest exposed by
// the CoClass EmpregadorRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoEmpregadorRequest = class
    class function Create: _EmpregadorRequest;
    class function CreateRemote(const MachineName: string): _EmpregadorRequest;
  end;

// *********************************************************************//
// The Class CoNetworkRequest provides a Create and CreateRemote method to
// create instances of the default interface _NetworkRequest exposed by
// the CoClass NetworkRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoNetworkRequest = class
    class function Create: _NetworkRequest;
    class function CreateRemote(const MachineName: string): _NetworkRequest;
  end;

// *********************************************************************//
// The Class CoUserDeleteRequest provides a Create and CreateRemote method to
// create instances of the default interface _UserDeleteRequest exposed by
// the CoClass UserDeleteRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUserDeleteRequest = class
    class function Create: _UserDeleteRequest;
    class function CreateRemote(const MachineName: string): _UserDeleteRequest;
  end;

// *********************************************************************//
// The Class CoUserUpdateRequest provides a Create and CreateRemote method to
// create instances of the default interface _UserUpdateRequest exposed by
// the CoClass UserUpdateRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUserUpdateRequest = class
    class function Create: _UserUpdateRequest;
    class function CreateRemote(const MachineName: string): _UserUpdateRequest;
  end;

// *********************************************************************//
// The Class CoUserAddRequest provides a Create and CreateRemote method to
// create instances of the default interface _UserAddRequest exposed by
// the CoClass UserAddRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUserAddRequest = class
    class function Create: _UserAddRequest;
    class function CreateRemote(const MachineName: string): _UserAddRequest;
  end;

// *********************************************************************//
// The Class CoUserRequest provides a Create and CreateRemote method to
// create instances of the default interface _UserRequest exposed by
// the CoClass UserRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUserRequest = class
    class function Create: _UserRequest;
    class function CreateRemote(const MachineName: string): _UserRequest;
  end;

// *********************************************************************//
// The Class CoDateTimeRequest provides a Create and CreateRemote method to
// create instances of the default interface _DateTimeRequest exposed by
// the CoClass DateTimeRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDateTimeRequest = class
    class function Create: _DateTimeRequest;
    class function CreateRemote(const MachineName: string): _DateTimeRequest;
  end;

// *********************************************************************//
// The Class CoiDCloudResult provides a Create and CreateRemote method to
// create instances of the default interface _iDCloudResult exposed by
// the CoClass iDCloudResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoiDCloudResult = class
    class function Create: _iDCloudResult;
    class function CreateRemote(const MachineName: string): _iDCloudResult;
  end;

// *********************************************************************//
// The Class CoStatusResult provides a Create and CreateRemote method to
// create instances of the default interface _StatusResult exposed by
// the CoClass StatusResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoStatusResult = class
    class function Create: _StatusResult;
    class function CreateRemote(const MachineName: string): _StatusResult;
  end;

// *********************************************************************//
// The Class CoTemplateMergeResult provides a Create and CreateRemote method to
// create instances of the default interface _TemplateMergeResult exposed by
// the CoClass TemplateMergeResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoTemplateMergeResult = class
    class function Create: _TemplateMergeResult;
    class function CreateRemote(const MachineName: string): _TemplateMergeResult;
  end;

// *********************************************************************//
// The Class CoTemplateResult provides a Create and CreateRemote method to
// create instances of the default interface _TemplateResult exposed by
// the CoClass TemplateResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoTemplateResult = class
    class function Create: _TemplateResult;
    class function CreateRemote(const MachineName: string): _TemplateResult;
  end;

// *********************************************************************//
// The Class CoNetworkResult provides a Create and CreateRemote method to
// create instances of the default interface _NetworkResult exposed by
// the CoClass NetworkResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoNetworkResult = class
    class function Create: _NetworkResult;
    class function CreateRemote(const MachineName: string): _NetworkResult;
  end;

// *********************************************************************//
// The Class CoDayLightResult provides a Create and CreateRemote method to
// create instances of the default interface _DayLightResult exposed by
// the CoClass DayLightResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDayLightResult = class
    class function Create: _DayLightResult;
    class function CreateRemote(const MachineName: string): _DayLightResult;
  end;

// *********************************************************************//
// The Class CoDate provides a Create and CreateRemote method to
// create instances of the default interface _Date exposed by
// the CoClass Date. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDate = class
    class function Create: _Date;
    class function CreateRemote(const MachineName: string): _Date;
  end;

// *********************************************************************//
// The Class CoEmpregadorResult provides a Create and CreateRemote method to
// create instances of the default interface _EmpregadorResult exposed by
// the CoClass EmpregadorResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoEmpregadorResult = class
    class function Create: _EmpregadorResult;
    class function CreateRemote(const MachineName: string): _EmpregadorResult;
  end;

// *********************************************************************//
// The Class CoCompany provides a Create and CreateRemote method to
// create instances of the default interface _Company exposed by
// the CoClass Company. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCompany = class
    class function Create: _Company;
    class function CreateRemote(const MachineName: string): _Company;
  end;

// *********************************************************************//
// The Class CoConnectRequest provides a Create and CreateRemote method to
// create instances of the default interface _ConnectRequest exposed by
// the CoClass ConnectRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoConnectRequest = class
    class function Create: _ConnectRequest;
    class function CreateRemote(const MachineName: string): _ConnectRequest;
  end;

// *********************************************************************//
// The Class CoLogoutRequest provides a Create and CreateRemote method to
// create instances of the default interface _LogoutRequest exposed by
// the CoClass LogoutRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoLogoutRequest = class
    class function Create: _LogoutRequest;
    class function CreateRemote(const MachineName: string): _LogoutRequest;
  end;

// *********************************************************************//
// The Class CoConnectResult provides a Create and CreateRemote method to
// create instances of the default interface _ConnectResult exposed by
// the CoClass ConnectResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoConnectResult = class
    class function Create: _ConnectResult;
    class function CreateRemote(const MachineName: string): _ConnectResult;
  end;

// *********************************************************************//
// The Class CoAboutResult provides a Create and CreateRemote method to
// create instances of the default interface _AboutResult exposed by
// the CoClass AboutResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAboutResult = class
    class function Create: _AboutResult;
    class function CreateRemote(const MachineName: string): _AboutResult;
  end;

// *********************************************************************//
// The Class CoInfoResult provides a Create and CreateRemote method to
// create instances of the default interface _InfoResult exposed by
// the CoClass InfoResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoInfoResult = class
    class function Create: _InfoResult;
    class function CreateRemote(const MachineName: string): _InfoResult;
  end;

// *********************************************************************//
// The Class CoAFDRequest provides a Create and CreateRemote method to
// create instances of the default interface _AFDRequest exposed by
// the CoClass AFDRequest. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAFDRequest = class
    class function Create: _AFDRequest;
    class function CreateRemote(const MachineName: string): _AFDRequest;
  end;

// *********************************************************************//
// The Class CoAFDResultLines provides a Create and CreateRemote method to
// create instances of the default interface _AFDResultLines exposed by
// the CoClass AFDResultLines. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAFDResultLines = class
    class function Create: _AFDResultLines;
    class function CreateRemote(const MachineName: string): _AFDResultLines;
  end;

// *********************************************************************//
// The Class CoAFDResultString provides a Create and CreateRemote method to
// create instances of the default interface _AFDResultString exposed by
// the CoClass AFDResultString. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAFDResultString = class
    class function Create: _AFDResultString;
    class function CreateRemote(const MachineName: string): _AFDResultString;
  end;

// *********************************************************************//
// The Class CoDateTimeResult provides a Create and CreateRemote method to
// create instances of the default interface _DateTimeResult exposed by
// the CoClass DateTimeResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDateTimeResult = class
    class function Create: _DateTimeResult;
    class function CreateRemote(const MachineName: string): _DateTimeResult;
  end;

// *********************************************************************//
// The Class CoUserResult provides a Create and CreateRemote method to
// create instances of the default interface _UserResult exposed by
// the CoClass UserResult. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUserResult = class
    class function Create: _UserResult;
    class function CreateRemote(const MachineName: string): _UserResult;
  end;

// *********************************************************************//
// The Class CoUser provides a Create and CreateRemote method to
// create instances of the default interface _User exposed by
// the CoClass User. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUser = class
    class function Create: _User;
    class function CreateRemote(const MachineName: string): _User;
  end;

// *********************************************************************//
// The Class CoSSLValidator provides a Create and CreateRemote method to
// create instances of the default interface _SSLValidator exposed by
// the CoClass SSLValidator. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSSLValidator = class
    class function Create: _SSLValidator;
    class function CreateRemote(const MachineName: string): _SSLValidator;
  end;

// *********************************************************************//
// The Class CoRestJSON provides a Create and CreateRemote method to
// create instances of the default interface _RestJSON exposed by
// the CoClass RestJSON. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRestJSON = class
    class function Create: _RestJSON;
    class function CreateRemote(const MachineName: string): _RestJSON;
  end;

implementation

uses ComObj;

class function CoRepCid_.Create: IRepCid;
begin
  Result := CreateComObject(CLASS_RepCid_) as IRepCid;
end;

class function CoRepCid_.CreateRemote(const MachineName: string): IRepCid;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RepCid_) as IRepCid;
end;

class function CoRepCidUsb.Create: IRepCidUsb;
begin
  Result := CreateComObject(CLASS_RepCidUsb) as IRepCidUsb;
end;

class function CoRepCidUsb.CreateRemote(const MachineName: string): IRepCidUsb;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RepCidUsb) as IRepCidUsb;
end;

class function CoSessionRequest.Create: _SessionRequest;
begin
  Result := CreateComObject(CLASS_SessionRequest) as _SessionRequest;
end;

class function CoSessionRequest.CreateRemote(const MachineName: string): _SessionRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SessionRequest) as _SessionRequest;
end;

class function CoiDCloudRequest.Create: _iDCloudRequest;
begin
  Result := CreateComObject(CLASS_iDCloudRequest) as _iDCloudRequest;
end;

class function CoiDCloudRequest.CreateRemote(const MachineName: string): _iDCloudRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_iDCloudRequest) as _iDCloudRequest;
end;

class function CoTemplateMergeRequest.Create: _TemplateMergeRequest;
begin
  Result := CreateComObject(CLASS_TemplateMergeRequest) as _TemplateMergeRequest;
end;

class function CoTemplateMergeRequest.CreateRemote(const MachineName: string): _TemplateMergeRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TemplateMergeRequest) as _TemplateMergeRequest;
end;

class function CoDayLightRequest.Create: _DayLightRequest;
begin
  Result := CreateComObject(CLASS_DayLightRequest) as _DayLightRequest;
end;

class function CoDayLightRequest.CreateRemote(const MachineName: string): _DayLightRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DayLightRequest) as _DayLightRequest;
end;

class function CoEmpregadorRequest.Create: _EmpregadorRequest;
begin
  Result := CreateComObject(CLASS_EmpregadorRequest) as _EmpregadorRequest;
end;

class function CoEmpregadorRequest.CreateRemote(const MachineName: string): _EmpregadorRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EmpregadorRequest) as _EmpregadorRequest;
end;

class function CoNetworkRequest.Create: _NetworkRequest;
begin
  Result := CreateComObject(CLASS_NetworkRequest) as _NetworkRequest;
end;

class function CoNetworkRequest.CreateRemote(const MachineName: string): _NetworkRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetworkRequest) as _NetworkRequest;
end;

class function CoUserDeleteRequest.Create: _UserDeleteRequest;
begin
  Result := CreateComObject(CLASS_UserDeleteRequest) as _UserDeleteRequest;
end;

class function CoUserDeleteRequest.CreateRemote(const MachineName: string): _UserDeleteRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserDeleteRequest) as _UserDeleteRequest;
end;

class function CoUserUpdateRequest.Create: _UserUpdateRequest;
begin
  Result := CreateComObject(CLASS_UserUpdateRequest) as _UserUpdateRequest;
end;

class function CoUserUpdateRequest.CreateRemote(const MachineName: string): _UserUpdateRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserUpdateRequest) as _UserUpdateRequest;
end;

class function CoUserAddRequest.Create: _UserAddRequest;
begin
  Result := CreateComObject(CLASS_UserAddRequest) as _UserAddRequest;
end;

class function CoUserAddRequest.CreateRemote(const MachineName: string): _UserAddRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserAddRequest) as _UserAddRequest;
end;

class function CoUserRequest.Create: _UserRequest;
begin
  Result := CreateComObject(CLASS_UserRequest) as _UserRequest;
end;

class function CoUserRequest.CreateRemote(const MachineName: string): _UserRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserRequest) as _UserRequest;
end;

class function CoDateTimeRequest.Create: _DateTimeRequest;
begin
  Result := CreateComObject(CLASS_DateTimeRequest) as _DateTimeRequest;
end;

class function CoDateTimeRequest.CreateRemote(const MachineName: string): _DateTimeRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DateTimeRequest) as _DateTimeRequest;
end;

class function CoiDCloudResult.Create: _iDCloudResult;
begin
  Result := CreateComObject(CLASS_iDCloudResult) as _iDCloudResult;
end;

class function CoiDCloudResult.CreateRemote(const MachineName: string): _iDCloudResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_iDCloudResult) as _iDCloudResult;
end;

class function CoStatusResult.Create: _StatusResult;
begin
  Result := CreateComObject(CLASS_StatusResult) as _StatusResult;
end;

class function CoStatusResult.CreateRemote(const MachineName: string): _StatusResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_StatusResult) as _StatusResult;
end;

class function CoTemplateMergeResult.Create: _TemplateMergeResult;
begin
  Result := CreateComObject(CLASS_TemplateMergeResult) as _TemplateMergeResult;
end;

class function CoTemplateMergeResult.CreateRemote(const MachineName: string): _TemplateMergeResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TemplateMergeResult) as _TemplateMergeResult;
end;

class function CoTemplateResult.Create: _TemplateResult;
begin
  Result := CreateComObject(CLASS_TemplateResult) as _TemplateResult;
end;

class function CoTemplateResult.CreateRemote(const MachineName: string): _TemplateResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TemplateResult) as _TemplateResult;
end;

class function CoNetworkResult.Create: _NetworkResult;
begin
  Result := CreateComObject(CLASS_NetworkResult) as _NetworkResult;
end;

class function CoNetworkResult.CreateRemote(const MachineName: string): _NetworkResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetworkResult) as _NetworkResult;
end;

class function CoDayLightResult.Create: _DayLightResult;
begin
  Result := CreateComObject(CLASS_DayLightResult) as _DayLightResult;
end;

class function CoDayLightResult.CreateRemote(const MachineName: string): _DayLightResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DayLightResult) as _DayLightResult;
end;

class function CoDate.Create: _Date;
begin
  Result := CreateComObject(CLASS_Date) as _Date;
end;

class function CoDate.CreateRemote(const MachineName: string): _Date;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Date) as _Date;
end;

class function CoEmpregadorResult.Create: _EmpregadorResult;
begin
  Result := CreateComObject(CLASS_EmpregadorResult) as _EmpregadorResult;
end;

class function CoEmpregadorResult.CreateRemote(const MachineName: string): _EmpregadorResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EmpregadorResult) as _EmpregadorResult;
end;

class function CoCompany.Create: _Company;
begin
  Result := CreateComObject(CLASS_Company) as _Company;
end;

class function CoCompany.CreateRemote(const MachineName: string): _Company;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Company) as _Company;
end;

class function CoConnectRequest.Create: _ConnectRequest;
begin
  Result := CreateComObject(CLASS_ConnectRequest) as _ConnectRequest;
end;

class function CoConnectRequest.CreateRemote(const MachineName: string): _ConnectRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ConnectRequest) as _ConnectRequest;
end;

class function CoLogoutRequest.Create: _LogoutRequest;
begin
  Result := CreateComObject(CLASS_LogoutRequest) as _LogoutRequest;
end;

class function CoLogoutRequest.CreateRemote(const MachineName: string): _LogoutRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LogoutRequest) as _LogoutRequest;
end;

class function CoConnectResult.Create: _ConnectResult;
begin
  Result := CreateComObject(CLASS_ConnectResult) as _ConnectResult;
end;

class function CoConnectResult.CreateRemote(const MachineName: string): _ConnectResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ConnectResult) as _ConnectResult;
end;

class function CoAboutResult.Create: _AboutResult;
begin
  Result := CreateComObject(CLASS_AboutResult) as _AboutResult;
end;

class function CoAboutResult.CreateRemote(const MachineName: string): _AboutResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AboutResult) as _AboutResult;
end;

class function CoInfoResult.Create: _InfoResult;
begin
  Result := CreateComObject(CLASS_InfoResult) as _InfoResult;
end;

class function CoInfoResult.CreateRemote(const MachineName: string): _InfoResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_InfoResult) as _InfoResult;
end;

class function CoAFDRequest.Create: _AFDRequest;
begin
  Result := CreateComObject(CLASS_AFDRequest) as _AFDRequest;
end;

class function CoAFDRequest.CreateRemote(const MachineName: string): _AFDRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AFDRequest) as _AFDRequest;
end;

class function CoAFDResultLines.Create: _AFDResultLines;
begin
  Result := CreateComObject(CLASS_AFDResultLines) as _AFDResultLines;
end;

class function CoAFDResultLines.CreateRemote(const MachineName: string): _AFDResultLines;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AFDResultLines) as _AFDResultLines;
end;

class function CoAFDResultString.Create: _AFDResultString;
begin
  Result := CreateComObject(CLASS_AFDResultString) as _AFDResultString;
end;

class function CoAFDResultString.CreateRemote(const MachineName: string): _AFDResultString;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AFDResultString) as _AFDResultString;
end;

class function CoDateTimeResult.Create: _DateTimeResult;
begin
  Result := CreateComObject(CLASS_DateTimeResult) as _DateTimeResult;
end;

class function CoDateTimeResult.CreateRemote(const MachineName: string): _DateTimeResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DateTimeResult) as _DateTimeResult;
end;

class function CoUserResult.Create: _UserResult;
begin
  Result := CreateComObject(CLASS_UserResult) as _UserResult;
end;

class function CoUserResult.CreateRemote(const MachineName: string): _UserResult;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserResult) as _UserResult;
end;

class function CoUser.Create: _User;
begin
  Result := CreateComObject(CLASS_User) as _User;
end;

class function CoUser.CreateRemote(const MachineName: string): _User;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_User) as _User;
end;

class function CoSSLValidator.Create: _SSLValidator;
begin
  Result := CreateComObject(CLASS_SSLValidator) as _SSLValidator;
end;

class function CoSSLValidator.CreateRemote(const MachineName: string): _SSLValidator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SSLValidator) as _SSLValidator;
end;

class function CoRestJSON.Create: _RestJSON;
begin
  Result := CreateComObject(CLASS_RestJSON) as _RestJSON;
end;

class function CoRestJSON.CreateRemote(const MachineName: string): _RestJSON;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RestJSON) as _RestJSON;
end;

end.

