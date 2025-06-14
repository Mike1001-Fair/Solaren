<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Message.Write(2, "Помилка авторизації");
try {
	Solaren.SetCmd("GetAreaSortCode");
	with (Cmd) {
		with (Parameters) {	
			Append(CreateParameter("SortCode", adTinyInt, adParamOutput, 10, 0));
		} Execute(adExecuteNoRecords);
	} Solaren.Close();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

var SortCode =++ Cmd.Parameters.Item("SortCode").value;
with (Html) {
	SetHead("Новий район");
	WriteScript();
	Menu.Write(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewArea" ACTION="createarea.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">Новий район</H3>
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=SortCode%>" MIN="1" MAX="255" READONLY></TD></TR>
	<TR ALIGN="RIGHT"><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="AreaName" SIZE="30" MAXLENGTH="20" REQUIRED AUTOFOCUS></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>


