<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.ValidateAccess(Authorized, "POST");

with (Request) {
    var StartSysDate    = String(Form("StartSysDate")),
	OperMonth       = String(Form("OperMonth")),
	HoursLimit      = String(Form("HoursLimit")),
	PanLimit        = Form("PanLimit"),
	BudgetItem      = Form("BudgetItem"),
	TreasuryName    = Form("TreasuryName"),
	TreasuryCode    = Form("TreasuryCode"),
	TreasuryAccount = Form("TreasuryAccount"),
	TreasuryMfo     = Form("TreasuryMfo"),
	SysConfig       = Form("SysConfig"),
	CheckCard       = Form("CheckCard") == "on",
	NewIndicator    = Form("NewIndicator") == "on",
	ShowMsg         = Form("ShowMsg") == "on",
	MsgText         = Form("MsgText");
}

try {
	Solaren.SetCmd("UpdateParameter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StartSysDate", adDBDate, adParamInput, 10, StartSysDate));
			Append(CreateParameter("OperMonth", adVarChar, adParamInput, 10, OperMonth));
			Append(CreateParameter("HoursLimit", adVarChar, adParamInput, 10, HoursLimit));
			Append(CreateParameter("PanLimit", adVarChar, adParamInput, 10, PanLimit));
			Append(CreateParameter("BudgetItem", adVarChar, adParamInput, 10, BudgetItem));
			Append(CreateParameter("TreasuryName", adVarChar, adParamInput, 50, TreasuryName));
			Append(CreateParameter("TreasuryCode", adVarChar, adParamInput, 10, TreasuryCode));
			Append(CreateParameter("TreasuryAccount", adVarChar, adParamInput, 30, TreasuryAccount));
			Append(CreateParameter("TreasuryMfo", adVarChar, adParamInput, 10, TreasuryMfo));
			Append(CreateParameter("SysConfig", adVarChar, adParamInput, 10, SysConfig));
			Append(CreateParameter("ShowMsg", adBoolean, adParamInput, 1, ShowMsg));
			Append(CreateParameter("MsgText", adVarChar, adParamInput, 800, MsgText)); 
		} Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	Connect.Close();
	var ym = OperMonth.split("-"),
	EndDate = new Date(ym[0], ym[1], 0),
	NextDate = new Date(ym[0], +ym[1] + 1, 0);
	Session("OperDate")     = OperMonth + "-01";
	Session("EndDate")      = EndDate.toStr(0);
	Session("NextDate")     = NextDate.toStr(0);
	Session("HoursLimit")   = HoursLimit;
	Session("CheckCard")    = CheckCard;
	Session("NewIndicator") = NewIndicator;
	Solaren.SysMsg(1, "");
}%>