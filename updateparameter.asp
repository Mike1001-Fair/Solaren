<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/session.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateParameter");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("StartSysDate", adDBDate, adParamInput, 10, Form.StartSysDate));
			Append(CreateParameter("OperMonth", adVarChar, adParamInput, 10, Form.OperMonth));
			Append(CreateParameter("HoursLimit", adVarChar, adParamInput, 10, Form.HoursLimit));
			Append(CreateParameter("PanLimit", adVarChar, adParamInput, 10, Form.PanLimit));
			Append(CreateParameter("BudgetItem", adVarChar, adParamInput, 10, Form.BudgetItem));
			Append(CreateParameter("TreasuryName", adVarChar, adParamInput, 50, Form.TreasuryName));
			Append(CreateParameter("TreasuryCode", adVarChar, adParamInput, 10, Form.TreasuryCode));
			Append(CreateParameter("TreasuryAccount", adVarChar, adParamInput, 30, Form.TreasuryAccount));
			Append(CreateParameter("TreasuryMfo", adVarChar, adParamInput, 10, Form.TreasuryMfo));
			Append(CreateParameter("SysConfig", adTinyInt, adParamInput, 10, Form.SysConfig));
			Append(CreateParameter("ShowMsg", adBoolean, adParamInput, 1, Form.ShowMsg == "on"));
			Append(CreateParameter("MsgText", adVarChar, adParamInput, 800, Form.MsgText)); 
		}
		Execute(adExecuteNoRecords);
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Solaren.Close();
	var OperDate = Form.OperMonth + "-01";
	Session("HoursLimit")   = String(Form.HoursLimit);
	Session("CheckCard")    = Form.CheckCard == "on";
	Session("NewIndicator") = Form.NewIndicator == "on";
	SessionManager.SetDate(OperDate);
	Message.Write(1, "");
}%>

