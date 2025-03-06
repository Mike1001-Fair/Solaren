<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");

with (Request) {
	var BranchId = Form("BranchId"),
	SortCode     = Form("SortCode"),
	BranchName1  = Form("BranchName1"),
	BranchName2  = Form("BranchName2"),
	AreaId       = Form("AreaId").Count == 1 ? Form("AreaId") : 0,
	LocalityId   = Form("LocalityId"),
	ChiefId      = Form("ChiefId"),
	Accountant   = Form("Accountant"),
	CompanyId    = Form("CompanyId");
}

try {
	Solaren.SetCmd("UpdateBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
			Append(CreateParameter("SortCode", adInteger, adParamInput, 10, SortCode));
			Append(CreateParameter("BranchName1", adVarChar, adParamInput, 50, BranchName1));
			Append(CreateParameter("BranchName2", adVarChar, adParamInput, 50, BranchName2));
			Append(CreateParameter("AreaId", adVarChar, adParamInput, 10, AreaId));
			Append(CreateParameter("LocalityId", adInteger, adParamInput, 10, LocalityId));
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
			Append(CreateParameter("Accountant", adVarChar, adParamInput, 30, Accountant));
			Append(CreateParameter("CompanyId", adInteger, adParamInput, 10, CompanyId));
			Append(CreateParameter("Done", adBoolean, adParamOutput, 1, 0));
		} Execute(adExecuteNoRecords);
		var Done = Parameters.Item("Done").value;
	}
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Connect.Close();
	Done ? Message.Write(1, "") : Message.Write(0, "ЦОС з таким номером вже є");
}%>