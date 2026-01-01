<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/new.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");
Html.SetPage("Друк договору")%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="PrintContract" TARGET="_blank" ACTION="prncontract.asp" METHOD="post" AUTOCOMPLETE="off">
<INPUT TYPE="hidden" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><IMG CLASS="H3Img" SRC="Images/printer.svg"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD><% Html.WriteSearchSet("Договір", "Contract", "", 1) %></TD></TR>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>&#128270;Пошук</BUTTON></FORM>
</BODY></HTML>


