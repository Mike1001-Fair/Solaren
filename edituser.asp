<%@ LANGUAGE="JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 0,
UserId = Request.QueryString("UserId");
User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!"),
	rsBranch = Solaren.Execute("SelectBranch", "Довiдник ЦОС пустий!");
	Cmd.Parameters.Item("UserId").value = UserId;
	var rsUser = Solaren.Execute("GetUser", "Користувача не знадено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Person = Solaren.Map(rsUser.Fields);
	rsUser.Close();
	Html.SetPage(Person.Deleted ? "Перегляд анкети" : "Редагування анкети");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditUser" ACTION="updateuser.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="UserId" VALUE="<%=UserId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Person.Deleted%>">
<H3 CLASS="HeadText" ID="H3Id">&#128100;<%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="UserSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=Person.LastName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=Person.FirstName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" VALUE="<%=Person.MiddleName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="TEXT" NAME="LoginId" VALUE="<%=Person.LoginId%>" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" SIZE="20" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Пароль</TD>
	<TD><INPUT TYPE="password" NAME="Pswd" VALUE="" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" SIZE="20" MAXLENGTH="10" REQUIRED AUTOCOMPLETE="new-password">
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="SetPswd" ID="SetPswd" TITLE="Сгенерувати">&#128273;</BUTTON>
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="ShowPswd" ID="ShowPswd" TITLE="Показати">&#128065;</BUTTON></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%User.WriteRole("RoleId", Person.RoleId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="Tel" NAME="Phone" VALUE="<%=Person.Phone%>" PATTERN="\d{3,10}" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, Person.CompanyId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><% Html.WriteSelect(rsBranch, "Branch", 1, Person.BranchId)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Person.Deleted);
Solaren.Close() %>
</FORM></BODY></HTML>
