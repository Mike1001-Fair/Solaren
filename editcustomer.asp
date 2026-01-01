<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/edit.inc" -->
<% var Authorized = User.RoleId == 1,
Query = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("GetCustomer");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("CustomerId", adInteger, adParamInput, 10, Query.CustomerId));
		}
	}
	var rs = Solaren.Execute("GetCustomer");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {	
	var Customer = Solaren.Map(rs.Fields);
	rs.Close();
	Solaren.Close();
	Html.SetPage(Customer.Deleted ? "Перегляд анкети" : "Редагування анкети");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditCustomer" ACTION="updatecustomer.asp" METHOD="POST" AUTOCOMPLETE="off">
<INPUT TYPE="HIDDEN" NAME="CustomerId" VALUE="<%=Query.CustomerId%>">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="<%=Customer.AreaId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=Customer.LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="StreetId" ID="StreetId" VALUE="<%=Customer.StreetId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Customer.Deleted%>">

<H3 CLASS="HeadText"><BIG>&#128100;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CustomerSet"><LEGEND ALIGN="CENTER">Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" VALUE="<%=Customer.LastName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" VALUE="<%=Customer.FirstName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="ThirdName" VALUE="<%=Customer.ThirdName%>" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT"><INPUT TYPE="CheckBox" NAME="CodeType" ID="CodeType"><LABEL FOR="CodeType" ID="DocType">РНОКПП</LABEL></TD>
	<TD><INPUT TYPE="TEXT" NAME="CustomerCode" VALUE="<%=Customer.Code%>" SIZE="15" MAXLENGTH="10" REQUIRED>
	</TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="TEXT" NAME="Phone" VALUE="<%=Customer.Phone%>" SIZE="15" MAXLENGTH="10" PATTERN="\d{1,10}" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD><FIELDSET NAME="AddressSet"><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Район</TD>
	<TD><% Html.WriteInputDataList("Area", Customer.AreaName, 30) %></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", Customer.LocalityName, 30) %></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", Customer.StreetName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" VALUE="<%=Customer.HouseId%>" SIZE="20" MAXLENGTH="15"></TD></TR>
	</TABLE></FIELDSET></TD>
</TR></TABLE>
<% Html.WriteEditButton(1, Customer.Deleted)%>
</FORM></BODY></HTML>
