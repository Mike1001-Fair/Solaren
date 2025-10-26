<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
Branch = Solaren.Map(Request.Form);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("UpdateBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, Branch.BranchId));
			Append(CreateParameter("SortCode", adInteger, adParamInput, 10, Branch.SortCode));
			Append(CreateParameter("BranchName1", adVarChar, adParamInput, 50, Branch.BranchName1));
			Append(CreateParameter("BranchName2", adVarChar, adParamInput, 50, Branch.BranchName2));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, Branch.AreaId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, Branch.LocalityId));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, Branch.ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Branch.Accountant));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, Branch.CompanyId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} 
		Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Solaren.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "ЦОС з таким номером вже є");
}%>

