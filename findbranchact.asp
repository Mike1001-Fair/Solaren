<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "GET")

try {
	Solaren.SetCmd("SelectBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsBranch = Solaren.Execute("SelectBranch", "Довiдник ЦОС пустий");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

Html.SetPage("Перевірка актів", User.RoleId)%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindBranchAct" ACTION="listbranchact.asp" METHOD="post" TARGET="_blank">
<INPUT TYPE="HIDDEN" NAME="BranchName">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<% Html.WriteMonthPeriod() %>	
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<LABEL>ЦОС
	<% Html.WriteSelect(rsBranch, "Branch", 0, -1);
	Connect.Close()%>
	</LABEL></FIELDSET>	
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn">&#128270;Пошук</BUTTON></FORM></BODY></HTML>