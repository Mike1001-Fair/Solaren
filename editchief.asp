<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2,
ChiefId = Request.QueryString("ChiefId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");


try {
	Solaren.SetCmd("SelectChiefTitle");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 3, Session("UserId")));
		}
	}
	var rsChiefTitle = Cmd.Execute();
	Solaren.EOF(rsChiefTitle, "Довiдник посад пустий!");
	Cmd.CommandText = "SelectChiefDoc";
	var rsChiefDoc = Cmd.Execute();
	Solaren.EOF(rsChiefTitle, "Довiдник документів керівника пустий!");
	with (Cmd) {
		CommandText = "GetChief";
		with (Parameters) {
			Append(CreateParameter("ChiefId", adInteger, adParamInput, 10, ChiefId));
		}
	}
	var rsChief = Cmd.Execute();
	with (rsChief) {
		var TitleId    = Fields("TitleId").value,
		Name1          = Fields("Name1").value,
		Name2          = Fields("Name2").value,
		Name3          = Fields("Name3").value,
		ChiefDocId     = Fields("ChiefDocId").value,
		TrustedDocId   = Fields("TrustedDocId").value,
		TrustedDocDate = Fields("TrustedDocDate").value,
		Deleted        = Fields("Deleted").value,
		HeadTitle      = Deleted ? "Перегляд анкети" : "Редагування анкети";
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditChief" ACTION="updatechief.asp" METHOD="POST" AUTOCOMPLETE="off">
<H3 CLASS="HeadText"><SPAN>&#128100;</SPAN><%=HeadTitle%></H3>
<SPAN CLASS="H3Span">керiвника</SPAN>
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
	<TD><%Html.WriteChiefDoc(rsChiefDoc, ChiefDocId); Connect.Close()%></TD></TR>

	<TR><TD ALIGN="RIGHT">Довiренiсть</TD>
	<TD><INPUT TYPE="TEXT" NAME="TrustedDocId" VALUE="<%=TrustedDocId%>" SIZE="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Дата</TD>
	<TD><INPUT TYPE="date" NAME="TrustedDocDate" VALUE="<%=TrustedDocDate%>"></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>