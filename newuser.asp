<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId == 0,
Title = "Новий користувач";

User.CheckAuthorization(Authorized);

try {
	Solaren.SetCmd("SelectCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!"),
	rsBranch = Solaren.Execute("SelectBranch", "Довiдник ЦОС пустий!");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
}

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewUser" ACTION="createuser.asp" METHOD="post" AUTOCOMPLETE="off">
<H3 CLASS="HeadText">&#128100;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="tel" NAME="Phone" PATTERN="\d{3,10}" SIZE="10" maxLength="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="TEXT" NAME="LoginId" SIZE="20"  maxLength="10" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Пароль</TD>
	<TD><INPUT TYPE="password" NAME="Pswd" SIZE="20" maxLength="10" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" REQUIRED AUTOCOMPLETE="new-password">
	<BUTTON CLASS="IconBtn" NAME="SetPswd" ID="SetPswd" TITLE="Сгенерувати">&#128273;</BUTTON>
	<BUTTON CLASS="IconBtn" NAME="ShowPswd" ID="ShowPswd" TITLE="Показати">&#128065;</BUTTON></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%Html.WriteRole("RoleId", -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><%Html.WriteCompany(rsCompany, -1)%></TD></TR>

	<TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><%Html.WriteBranch(rsBranch, -1, 1);
	Connect.Close()%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>