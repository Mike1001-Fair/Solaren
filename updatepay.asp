<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
Payment = Solaren.Map(Request.Form);
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdatePay");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, Payment.ContractId));
			Append(CreateParameter("PayId", adInteger, adParamInput, 10, Payment.PayId));
			Append(CreateParameter("PayDate", adVarChar, adParamInput, 10, Payment.PayDate));
			Append(CreateParameter("PaySum", adVarChar, adParamInput, 20, Payment.PaySum));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "Сума оплати бiльше боргу")
}%>

