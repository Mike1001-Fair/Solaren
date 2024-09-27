<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<% var Authorized = Session("RoleId") == 0;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
	var SortCode = Form("SortCode"),
	BranchName1  = Form("BranchName1"),
	BranchName2  = Form("BranchName2"),
	AreaId       = Form("AreaId").Count == 1 ? Form("AreaId") : 0,
	LocalityId   = Form("LocalityId"),
	ChiefId      = Form("ChiefId"),
	Accountant   = Form("Accountant"),
	CompanyId    = Form("CompanyId");
}

try {
	Solaren.SetCmd("NewBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("SortCode", adVarChar, adParamInput, 10, SortCode));
			Append(CreateParameter("BranchName", adVarChar, adParamInput, 30, BranchName));
			Append(CreateParameter("BranchName2", adVarChar, adParamInput, 30, BranchName2));
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
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	Connect.Close();
	Done ? Solaren.SysMsg(1, "") : Solaren.SysMsg(0, "ЦОС з таким номером вже є");
}%>