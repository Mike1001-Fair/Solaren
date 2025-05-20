<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
CountryId = Request.Form("CountryId");
User.ValidateAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetCountry");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CountryId", adInteger, adParamInput, 10, CountryId));
		}
	}
	var rsCountry = Solaren.Execute("GetCountry");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rsCountry) {
		var CountryName = Fields("CountryName").value,
		TldCode         = Fields("TldCode").value,
		IsoCode         = Fields("IsoCode").value,
		ItuCode         = Fields("ItuCode").value,
		Deleted         = Fields("Deleted").value,
		Title           = Deleted ? "Перегляд країни" : "Редагування країни";
		Close();
	} 
	Solaren.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCountry" ACTION="updatecountry.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">&#127757;<%=Title%></H3>
<INPUT TYPE="HIDDEN" NAME="CountryId" VALUE="<%=CountryId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CountrySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CountryName" VALUE="<%=CountryName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD>Tld-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="TldCode" VALUE="<%=TldCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Iso-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="IsoCode" VALUE="<%=IsoCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Itu-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="ItuCode" VALUE="<%=ItuCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>

