<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/upsert.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Form.BranchId));
			Append(CreateParameter("SortCode", adInteger, adParamInput, 10, Form.SortCode));
			Append(CreateParameter("BranchName1", adVarChar, adParamInput, 50, Form.BranchName1));
			Append(CreateParameter("BranchName2", adVarChar, adParamInput, 50, Form.BranchName2));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, Form.AreaId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Form.LocalityId));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Form.ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Form.Accountant));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Form.CompanyId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").Value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "ЦОС з таким номером вже є");
}%>

