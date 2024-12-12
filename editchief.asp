<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
ChiefId = Request.QueryString("ChiefId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, User.Id));
		}
	}
	var rsChiefTitle = Solaren.Execute("SelectChiefTitle", "Довiдник посад пустий!"),
	rsChiefDoc = Solaren.Execute("SelectChiefDoc", "Довiдник документів керівника пустий!");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
		}
	}
	var rsChief = Solaren.Execute("GetChief", "Керівника не знайдено!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {
	with (rsChief) {
		var TitleId    = Fields("TitleId").value,
		Name1          = Fields("Name1").value,
		Name2          = Fields("Name2").value,
		Name3          = Fields("Name3").value,
		ChiefDocId     = Fields("ChiefDocId").value,
		TrustedDocId   = Fields("TrustedDocId").value,
		TrustedDocDate = Fields("TrustedDocDate").value,
		Deleted        = Fields("Deleted").value,
		Title          = Deleted ? "Перегляд анкети" : "Редагування анкети";
		Close();
	}
	Html.SetPage(Title, User.RoleId);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChief" ACTION="updatechief.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><%=Title%></H3>

<INPUT TYPE="HIDDEN" NAME="ChiefId" VALUE="<%=ChiefId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<TABLE CLASS="MarkupTable">
	<TR ALIGN="CENTER"><TD>
	<FIELDSET NAME="ChiefSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Посада</TD>
	<TD><%Html.WriteChiefTitle(rsChiefTitle, TitleId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Хто?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name1" PLACEHOLDER="ПІБ" VALUE="<%=Name1%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name2" PLACEHOLDER="ПІБ" VALUE="<%=Name2%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Кому?</TD>
	<TD><INPUT TYPE="TEXT" NAME="Name3" PLACEHOLDER="ПІБ" VALUE="<%=Name3%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Документ</TD>
	<TD><%Html.WriteChiefDoc(rsChiefDoc, ChiefDocId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Довiренiсть</TD>
	<TD><INPUT TYPE="TEXT" NAME="TrustedDocId" VALUE="<%=TrustedDocId%>" SIZE="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="TrustedDocDate" VALUE="<%=TrustedDocDate%>"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Connect.Close();
Html.WriteEditButton(1)%>
</FORM></BODY></HTML>