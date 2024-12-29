<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetOperatorSortCode");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("SortCode", adTinyInt, adParamOutput, 10, 0));
		} Execute(adExecuteNoRecords);
	} 
	var SortCode = Cmd.Parameters.Item("SortCode").value;
	Connect.Close();
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead("Новий оператор");
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOperator" ACTION="createoperator.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><IMG SRC="Images/OperatorIcon.svg">Новий оператор</H3>
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