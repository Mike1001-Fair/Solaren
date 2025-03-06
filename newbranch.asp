<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0;
User.ValidateAccess(Authorized, "GET");

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
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsChief = Solaren.Execute("SelectChiefBranch", "Довiдник керівників пустий!"),
	rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Новий ЦОС", User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewBranch" ACTION="createbranch.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="AreaId" ID="AreaId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<H3 CLASS="HeadText">&#127980;<%=Html.Title%></H3>
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
	<TD><% Html.WriteInputDataList("Area", "", 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", "", 30) %></TD></TR>
	
	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="&#128100;ПІБ" SIZE="30" maxLength="20" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, -1)%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>
