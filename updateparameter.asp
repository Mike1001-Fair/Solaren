<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/session.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Parameter = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateParameter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StartSysDate", adDBDate, adParamInput, 10, Parameter.StartSysDate));
			Append(CreateParameter("OperMonth", adVarChar, adParamInput, 10, Parameter.OperMonth));
			Append(CreateParameter("HoursLimit", adVarChar, adParamInput, 10, Parameter.HoursLimit));
			Append(CreateParameter("PanLimit", adVarChar, adParamInput, 10, Parameter.PanLimit));
			Append(CreateParameter("BudgetItem", adVarChar, adParamInput, 10, Parameter.BudgetItem));
			Append(CreateParameter("TreasuryName", adVarChar, adParamInput, 50, Parameter.TreasuryName));
			Append(CreateParameter("TreasuryCode", adVarChar, adParamInput, 10, Parameter.TreasuryCode));
			Append(CreateParameter("TreasuryAccount", adVarChar, adParamInput, 30, Parameter.TreasuryAccount));
			Append(CreateParameter("TreasuryMfo", adVarChar, adParamInput, 10, Parameter.TreasuryMfo));
			Append(CreateParameter("SysConfig", adTinyInt, adParamInput, 10, Parameter.SysConfig));
			Append(CreateParameter("ShowMsg", adBoolean, adParamInput, 1, Parameter.ShowMsg == "on"));
			Append(CreateParameter("MsgText", adVarChar, adParamInput, 800, Parameter.MsgText)); 
		}
		Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Solaren.Close();
	var OperDate = Parameter.OperMonth + "-01";
	Session("HoursLimit")   = String(Parameter.HoursLimit);
	Session("CheckCard")    = Parameter.CheckCard == "on";
	Session("NewIndicator") = Parameter.NewIndicator == "on";
	SessionManager.SetDate(OperDate);
	Message.Write(1, "");
}%>

