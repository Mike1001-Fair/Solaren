<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
ReadOnly = Session("RoleId") > 0,
BranchId = Request.QueryString("BranchId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("SelectChiefBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}	
	var rsChief = Solaren.Execute("SelectChiefBranch", "Довiдник керівників пустий!"),
	rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
		}
	}

	var rsBranch = Solaren.Execute("GetBranch", "Інформацію не знадено!");
	with (rsBranch) {
		var SortCode = Fields("SortCode").value,
		BranchName1  = Fields("BranchName1").value,
		BranchName2  = Fields("BranchName2").value,
		AreaId       = Fields("AreaId").value,
		AreaName     = Fields("AreaName").value,
		LocalityId   = Fields("LocalityId").value,
		LocalityName = Fields("LocalityName").value,
		ChiefId      = Fields("ChiefId").value,
		Accountant   = Fields("Accountant").value,
		CompanyId    = Fields("CompanyId").value,
		Deleted      = Fields("Deleted").value,
		Title        = Deleted ? "Перегляд анкети ЦОС" : "Редагування анкети ЦОС";
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

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

	<TR><TD ALIGN="RIGHT">Чого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName2" PLACEHOLDER="Коротка без лапок" VALUE="<%=BranchName2%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Район</TD>
	<TD><% Html.WriteInputDataList("Area", AreaName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", LocalityName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, ChiefId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" VALUE="<%=Accountant%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, CompanyId)%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1);
Connect.Close() %>
</FORM></BODY></HTML>