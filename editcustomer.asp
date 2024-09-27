<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") == 1,
CustomerId = Request.QueryString("CustomerId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, CustomerId));
		}
	}
	var rsCustomer = Cmd.Execute();
	with (rsCustomer) {
		var CustomerCode = Fields("Code").value,
		LastName         = Fields("LastName").value,
		FirstName        = Fields("FirstName").value,
		ThirdName        = Fields("ThirdName").value,
		AreaId           = Fields("AreaId").value,
		AreaName         = Fields("AreaName").value,
		LocalityId       = Fields("LocalityId").value,
		LocalityName     = Fields("LocalityName").value,
		StreetId         = Fields("StreetId").value,
		StreetName       = Fields("StreetName").value,
		HouseId          = Fields("HouseId").value,
		Phone            = Fields("Phone").value,
		Deleted          = Fields("Deleted").value,
		HeadTitle        = Deleted ? "Перегляд анкети споживача" : "Редагування анкети споживача";
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
}

with (Html) {
	SetHead(HeadTitle);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCustomer" ACTION="updatecustomer.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="CustomerId" VALUE="<%=CustomerId%>">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="<%=AreaId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><BIG>&#128100;</BIG><%=HeadTitle%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CustomerSet"><LEGEND ALIGN="CENTER">Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=LastName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=FirstName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="ThirdName" VALUE="<%=ThirdName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT"><INPUT TYPE="CheckBox" NAME="CodeType" ID="CodeType"><LABEL FOR="CodeType" ID="DocType">РНОКПП</LABEL></TD>
	<TD><INPUT TYPE="TEXT" NAME="CustomerCode" VALUE="<%=CustomerCode%>" SIZE="15" MAXLENGTH="10" REQUIRED>
	</TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="TEXT" NAME="Phone" VALUE="<%=Phone%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{1,10}" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD><FIELDSET NAME="AddressSet"><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Район</TD>
	<TD><INPUT TYPE="search" NAME="AreaName" ID="AreaName" VALUE="<%=AreaName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED>
	<DATALIST ID="AreaList"></DATALIST></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" VALUE="<%=LocalityName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><INPUT TYPE="search" NAME="StreetName" ID="StreetName" VALUE="<%=StreetName%>" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="StreetList" REQUIRED>
	<DATALIST ID="StreetList"></DATALIST>
	<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="<%=StreetId%>"></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=HouseId%>" SIZE="20" MAXLENGTH="15"></TD></TR>
	</TABLE></FIELDSET></TD>
</TR></TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>