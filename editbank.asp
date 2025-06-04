<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
BankId = Request.QueryString("BankId");

User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetBank");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BankId", adInteger, adParamInput, 10, BankId));
		}
	}
	var rsBank = Solaren.Execute("GetBank");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rsBank) {
		var EdrpoCode = Fields("EdrpoCode").value,
		MfoCode       = Fields("MfoCode").value,
		BankName      = Fields("BankName").value,
		Deleted       = Fields("Deleted").value,
		Title         = Deleted ? "Перегляд анкети" : "Редагування анкети";
		Close();
	}
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditBank" ACTION="updatebank.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="BankId" VALUE="<%=BankId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText" ID="H3Id"><SPAN>&#127974;</SPAN><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="BankSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Код</TD>
	<TD><INPUT TYPE="TEXT" NAME="EdrpoCode" PLACEHOLDER="ЄДРПОУ" VALUE="<%=EdrpoCode%>" SIZE="10" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="TEXT" NAME="MfoCode" VALUE="<%=MfoCode%>" SIZE="10" MAXLENGTH="6" PATTERN="\d{6}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="BankName" PLACEHOLDER="Коротка без лапок" VALUE="<%=BankName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>


