<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");
Html.SetPage("Новий споживач")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewCustomer" ACTION="createcustomer.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="AreaId" ID="AreaId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128100;</BIG><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET NAME="CustomerSet"><LEGEND>Загальні</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Прiзвище</TD>
	<TD><INPUT TYPE="TEXT" NAME="LastName" SIZE="20" MAXLENGTH="15" AUTOFOCUS REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Iм'я</TD>
	<TD><INPUT TYPE="TEXT" NAME="FirstName" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">По батьковi</TD>
	<TD><INPUT TYPE="TEXT" NAME="ThirdName" SIZE="20" MAXLENGTH="15" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT"><INPUT TYPE="CheckBox" NAME="CodeType" ID="CodeType"><LABEL FOR="CodeType" ID="DocType">РНОКПП</LABEL></TD>
	<TD><INPUT TYPE="TEXT" NAME="CustomerCode" SIZE="15" MAXLENGTH="10" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Телефон</TD>
	<TD><INPUT TYPE="tel" NAME="Phone" SIZE="15" MAXLENGTH="10" PATTERN="\d{10}" REQUIRED></TD></TR>
	</TABLE></FIELDSET></TD>

	<TD><FIELDSET NAME="AddressSet"><LEGEND>Адреса</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">Район</TD>
	<TD><% Html.WriteInputDataList("Area", "", 30) %></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", "", 30) %></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><% Html.WriteInputDataList("Street", "", 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" SIZE="20" MAXLENGTH="15"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>


