<%@ LANGUAGE="JScript"%>
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<% var Authorized = User.RoleId == 0,
ValidRequest = Solaren.HTTPMethod("GET", 1),
UserId = Request.QueryString("UserId");

User.ValidateAccess(Authorized);

if (!ValidRequest) {
	Solaren.SysMsg(0, "Помилка запиту")
}

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
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
}

with (rsUser) {
    var CompanyId  = Fields("CompanyId").value,
	LoginId	   = Fields("LoginId").value,
	RoleId     = Fields("RoleId").value,
	LastName   = Fields("LastName").value,
	FirstName  = Fields("FirstName").value,
	MiddleName = Fields("MiddleName").value,
	Phone      = Fields("Phone").value,
	BranchId   = Fields("BranchId").value,
	Deleted    = Fields("Deleted").value,
	Title      = Deleted ? "Перегляд анкети" : "Редагування анкети";
	Close();
}

Html.SetPage(Title, User.RoleId)%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditUser" ACTION="updateuser.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="UserId" VALUE="<%=UserId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">
<H3 CLASS="HeadText" ID="H3Id">&#128100;<%=Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="UserSet"><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=LastName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=FirstName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="MiddleName" VALUE="<%=MiddleName%>" SIZE="20" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Логiн</TD>
	<TD><INPUT TYPE="TEXT" NAME="LoginId" VALUE="<%=LoginId%>" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" SIZE="20" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Пароль</TD>
	<TD><INPUT TYPE="password" NAME="Pswd" VALUE="" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" SIZE="20" MAXLENGTH="10" REQUIRED AUTOCOMPLETE="new-password">
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="SetPswd" ID="SetPswd" TITLE="Сгенерувати">&#128273;</BUTTON>
	<BUTTON TYPE="button" CLASS="IconBtn" NAME="ShowPswd" ID="ShowPswd" TITLE="Показати">&#128065;</BUTTON></TD></TR>
	<TR><TD ALIGN="RIGHT">Роль</TD>
	<TD><%Html.WriteRole("RoleId", RoleId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="Tel" NAME="Phone" VALUE="<%=Phone%>" PATTERN="\d{3,10}" SIZE="10" MAXLENGTH="10" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, CompanyId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">ЦОС</TD>
	<TD><% Html.WriteSelect(rsBranch, "Branch", 1, BranchId)%></TD></TR>
	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1);
Connect.Close() %>
</FORM></BODY></HTML>