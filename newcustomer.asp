<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var RoleId = Session("RoleId"),
Authorized = RoleId == 1,
Title = "Новий споживач";

Authorized ? Html.SetPage(Title, RoleId) : Solaren.SysMsg(2, "Помилка авторизації")%>

<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewCustomer" ACTION="createcustomer.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="AreaId" ID="AreaId" VALUE="-1">
<INPUT TYPE="hidden" NAME="LocalityId" ID="LocalityId" VALUE="-1">
<INPUT TYPE="hidden" NAME="StreetId" ID="StreetId" VALUE="-1">
<H3 CLASS="HeadText"><BIG>&#128100;</BIG><%=Title%></H3>
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
	<TD><INPUT TYPE="search" NAME="AreaName" ID="AreaName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="AreaList" REQUIRED>
	<DATALIST ID="AreaList"></DATALIST></TD></TR>

	<TR><TD ID="LocalityType" ALIGN="RIGHT">Пункт</TD>
	<TD><INPUT TYPE="search" NAME="LocalityName" ID="LocalityName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="LocalityList" REQUIRED>
	<DATALIST ID="LocalityList"></DATALIST></TD></TR>

	<TR><TD ID="StreetType" ALIGN="RIGHT">Вулиця</TD>
	<TD><INPUT TYPE="search" NAME="StreetName" ID="StreetName" PLACEHOLDER="Пошук по літерам" SIZE="30" LIST="StreetList" REQUIRED>
	<DATALIST ID="StreetList"></DATALIST></TD></TR>

	<TR><TD ALIGN="RIGHT">Будинок</TD>
	<TD><INPUT TYPE="TEXT" NAME="HouseId" SIZE="20" MAXLENGTH="15"></TD></TR>
	</TABLE></FIELDSET>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON>
</FORM></BODY></HTML>