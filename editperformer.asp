<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1,
PerformerId = Request.QueryString("PerformerId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetPerformer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("PerformerId", adInteger, adParamInput, 10, PerformerId));
		}
	}
	var rs = Solaren.Execute("GetPerformer", "Iнформацiю не знайдено");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	with (rs) {
		var LastName = Fields("LastName").value,
		FirstName    = Fields("FirstName").value,
		MiddleName   = Fields("MiddleName").value,
		Phone        = Fields("Phone").value,
		Title        = "Редагування анкети виконавця";
		Close();
	}
	Solaren.Close();
}

Html.SetPage(Title, User.RoleId)%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditPerformer" ACTION="updateperformer.asp" METHOD="POST">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<INPUT TYPE="HIDDEN" NAME="PerformerId" VALUE="<%=PerformerId%>">
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=LastName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=FirstName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" VALUE="<%=MiddleName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="phone" NAME="Phone" VALUE="<%=Phone%>" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#128190;Зберегти</BUTTON></FORM></BODY></HTML>
