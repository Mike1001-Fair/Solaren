<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 0,
Title = "Новий ЦОС";

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetBranchSortCode");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("SortCode", adTinyInt, adParamOutput, 10, 0));
		} Execute();
	} 
	var SortCode =++ Cmd.Parameters.Item("SortCode").value;

	with (Cmd) {
		CommandText = "SelectChiefBranch";
		with (Parameters) {
			Delete("SortCode");
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rsChief = Solaren.Execute("SelectChiefBranch", "Довiдник керівників пустий!"),
	rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewBranch" ACTION="createbranch.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="AreaId" ID="AreaId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<H3 CLASS="HeadText">&#127980;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" READONLY></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT"NAME="BranchName" PLACEHOLDER="Коротка без лапок" SIZE="30" maxLength="30" REQUIRED AUTOFOCUS></TD></TR>

	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName2" PLACEHOLDER="Коротка без лапок" SIZE="30" maxLength="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Район</TD>
	<TD><INPUT TYPE="search" NAME="AreaName" ID="AreaName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED>
	<DATALIST ID="AreaList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Пункт</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><%Html.WriteChief(rsChief, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="&#128100;ПІБ" SIZE="30" maxLength="20" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><%Html.WriteCompany(rsCompany, -1)%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>