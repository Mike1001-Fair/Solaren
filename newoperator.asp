<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetOperatorSortCode");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("SortCode", adTinyInt, adParamOutput, 10, 0));
		} Execute(adExecuteNoRecords);
	} 
	var SortCode = Cmd.Parameters.Item("SortCode").Value;
	Solaren.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Новий оператор")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOperator" ACTION="createoperator.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><IMG SRC="Images/OperatorIcon.svg"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" READONLY></TD></TR>
	<TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="EdrpoCode" PLACEHOLDER="ЄДРПОУ" SIZE="9" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED AUTOFOCUS></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="OperatorName" PLACEHOLDER="Коротка без лапок" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>
</TR></TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>


