<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Include/find.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");
Html.SetPage("Пошук операцій")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="FindOper" ACTION="listoper.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Month.WritePeriod();
	Html.WriteSearchSet("Договір", "Contract", "", 1);%>
	</TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON>
</FORM></BODY></HTML>



