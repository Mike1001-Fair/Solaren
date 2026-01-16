<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->

<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
CountryId = Request.Form("CountryId");
User.CheckAccess(Authorized, "POST");

try {
	Db.SetCmd("GetCountry");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CountryId", adInteger, adParamInput, 10, CountryId));
		}
	}
	var rs = Db.Execute("GetCountry");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rs.Fields);
	rs.Close();
	Db.Close();
	Html.SetPage(Record.Deleted ? "Перегляд анкети" : "Редагування анкети");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCountry" ACTION="updatecountry.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">&#127757;<%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="CountryId" VALUE="<%=CountryId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CountrySet"><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD>Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="CountryName" VALUE="<%=Record.CountryName%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD>Tld-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="TldCode" VALUE="<%=Record.TldCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Iso-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="IsoCode" VALUE="<%=Record.IsoCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD>Itu-код</TD>
	<TD><INPUT TYPE="TEXT" NAME="ItuCode" VALUE="<%=Record.ItuCode%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted)%>
</FORM></BODY></HTML>