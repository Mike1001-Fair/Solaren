<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 1 && User.RoleId <= 2,
Indicator = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, User.Id));
			Append(CreateParameter("IndicatorId", adInteger, adParamInput,10, Indicator.IndicatorId));
			Append(CreateParameter("ReportDate", adVarChar, adParamInput, 10, Indicator.ReportDate));
			Append(CreateParameter("MeterId", adInteger, adParamInput, 10, Indicator.MeterId));
			Append(CreateParameter("RecVal", adInteger, adParamInput, 10, Indicator.RecVal));
			Append(CreateParameter("RetVal", adInteger, adParamInput, 10, Indicator.RetVal));
			Append(CreateParameter("PrevDate", adVarChar, adParamInput, 10, Indicator.PrevDate));
			Append(CreateParameter("RecSaldo", adInteger, adParamInput, 10, Indicator.RecSaldo));
			Append(CreateParameter("RetSaldo", adInteger, adParamInput, 10, Indicator.RetSaldo));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Показники з такою датою вже є")
}%>

