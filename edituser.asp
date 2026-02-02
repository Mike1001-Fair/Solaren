<%@ LANGUAGE="JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = User.RoleId == 0,
Query = Webserver.Parse();
User.CheckAccess(Authorized, "GET");

try {
	Db.SetCmd("SelectCompany");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rsCompany = Db.Execute("SelectCompany", "Довiдник підприємств пустий!"),
	rsBranch = Db.Execute("SelectBranch", "Довiдник ЦОС пустий!");
	Cmd.Parameters.Item("UserId").Value = Query.UserId;
	var rsUser = Db.Execute("GetUser", "Користувача не знадено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Record = Webserver.Map(rsUser.Fields),
	Title = Record.Deleted ? "Перегляд анкети" : "Редагування анкети";
	rsUser.Close();
	Html.SetPage(Title);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditUser" ACTION="updateuser.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="UserId" VALUE="<%=Record.UserId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Record.Deleted%>">
<H3 CLASS="HeadText" ID="H3Id">&#128100;<%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="UserSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=Record.LastName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=Record.FirstName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" VALUE="<%=Record.MiddleName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="TEXT" NAME="UserName" VALUE="<%=Record.UserName%>" PATTERN="^[a-zA-Z0-9._-]{8,16}$" SIZE="20" minLength="8" maxLength="16" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Пароль</TD>
	<TD><INPUT TYPE="password" NAME="Pswd" VALUE="" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{16}" SIZE="20" MAXLENGTH="16" REQUIRED AUTOCOMPLETE="new-password">
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="SetPswd" ID="SetPswd" TITLE="Сгенерувати">&#128273;</BUTTON>
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="ShowPswd" ID="ShowPswd" TITLE="Показати">&#128065;</BUTTON></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%User.WriteRole("RoleId", Record.RoleId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="Tel" NAME="Phone" VALUE="<%=Record.Phone%>" PATTERN="\d{3,10}" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, Record.CompanyId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><% Html.WriteSelect(rsBranch, "Branch", 1, Record.BranchId)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Record.Deleted);
Db.Close() %>
</FORM></BODY></HTML>
