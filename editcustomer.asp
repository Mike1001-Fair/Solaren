<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var RoleId = Session("RoleId"),
Authorized = RoleId == 1,
CustomerId = Request.QueryString("CustomerId");

if (!Authorized) {
	Message.Write(2, "Помилка авторизації");
}

try {
	Solaren.SetCmd("GetCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, CustomerId));
		}
	}
	var rs = Solaren.Execute("GetCustomer");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	with (rs) {
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
		Title            = Deleted ? "Перегляд анкети" : "Редагування анкети";
	}
	Solaren.Close();
	Html.SetPage(Title, RoleId);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCustomer" ACTION="updatecustomer.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="CustomerId" VALUE="<%=CustomerId%>">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="<%=AreaId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="StreetId" ID="StreetId" VALUE="<%=StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Deleted%>">

<H3 CLASS="HeadText"><BIG>&#128100;</BIG><%=Html.Title%></H3>
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
	<TD><% Html.WriteInputDataList("Area", AreaName, 30) %></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", LocalityName, 30) %></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", StreetName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=HouseId%>" SIZE="20" MAXLENGTH="15"></TD></TR>
	</TABLE></FIELDSET></TD>
</TR></TABLE>
<% Html.WriteEditButton(1)%>
</FORM></BODY></HTML>
