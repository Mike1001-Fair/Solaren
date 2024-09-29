<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
BranchId = Request.QueryString("BranchId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChiefBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsChief = Cmd.Execute();
	Solaren.EOF(rsChief, "Довiдник керівників пустий!");
	Cmd.CommandText = "SelectCompany";
	var rsCompany = Cmd.Execute();
	Solaren.EOF(rsCompany, "Довiдник постачальникiв пустий!");
	with (Cmd) {
		CommandText = "GetBranch";
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
		}
	}

	var rsBranch = Cmd.Execute();
	Solaren.EOF(rsBranch, "Інформацію не знадено!");
	with (rsBranch) {
		var SortCode   = Fields("SortCode").value,
		BranchName1    = Fields("BranchName1").value,
		BranchName2    = Fields("BranchName2").value,
		AreaId         = Fields("AreaId").value,
		AreaName       = Fields("AreaName").value,
		LocalityId     = Fields("LocalityId").value,
		LocalityName   = Fields("LocalityName").value,
		ChiefId        = Fields("ChiefId").value,
		Accountant     = Fields("Accountant").value,
		CompanyId      = Fields("CompanyId").value,
		Deleted        = Fields("Deleted").value;
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

var ReadOnly = Session("RoleId") > 0,
Title = Deleted ? "Перегляд анкети ЦОС" : "Редагування анкети ЦОС";

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditBranch" ACTION="updatebranch.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="BranchId" VALUE="<%=BranchId%>">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="<%=AreaId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<INPUT TYPE="HIDDEN" NAME="ReadOnly" VALUE="<%=ReadOnly%>">

<H3 CLASS="HeadText" ID="H3Id">&#127980;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="99" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName1" PLACEHOLDER="Коротка без лапок" VALUE="<%=BranchName1%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName2" PLACEHOLDER="Коротка без лапок" VALUE="<%=BranchName2%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Район</TD>
	<TD><INPUT TYPE="search" NAME="AreaName" ID="AreaName" VALUE="<%=AreaName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED>
	<DATALIST ID="AreaList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Пункт</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" VALUE="<%=LocalityName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><%Html.WriteChief(rsChief, ChiefId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" VALUE="<%=Accountant%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><SELECT NAME="CompanyId">
	<% for (; !rsCompany.EOF; rsCompany.MoveNext()) {
		if (rsCompany.Fields("CompanyId") == CompanyId) {
			Response.Write('<OPTION VALUE="' + rsCompany.Fields("CompanyId") + '" SELECTED>' + rsCompany.Fields("CompanyName") + '</OPTION>')
		} else if (Session("RoleId") == 0) {
			Response.Write('<OPTION VALUE="' + rsCompany.Fields("CompanyId") + '">' + rsCompany.Fields("CompanyName") + '</OPTION>')
		}
	} rsCompany.Close();
	Connect.Close()%></SELECT></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>