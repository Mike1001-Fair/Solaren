<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE VIRTUAL="Solaren/Set/new.set" -->
<% var Authorized = User.RoleId == 1;
if (User.CheckAccess(Authorized, "GET")) {
	Html.SetPage("Нова операція")
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewOper" ACTION="createoper.asp" METHOD="post">
<INPUT TYPE="HIDDEN" NAME="ContractId" ID="ContractId" VALUE="-1">
<H3 CLASS="HeadText"><%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
       	<TR><TD ALIGN="CENTER">
	<% Month.WriteDatePeriod("Період", Date[1], Date[2], Date[1], Date[2]);
	Html.WriteSearchSet("Договір", "Contract", "", 1);%>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Видача</TD>
	<TD><INPUT TYPE="Number" NAME="RetVol" STEP="1" MIN="0" MAX="999999" PLACEHOLDER="кВт&#183;год" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Вартість</TD>
	<TD><INPUT TYPE="Number" NAME="VolCost" STEP="0.01" MIN="0" MAX="99999999" PLACEHOLDER="&#8372;" REQUIRED></TD></TR>
	</TABLE></FIELDSET>
</TABLE>
<BUTTON CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn" DISABLED>Створити</BUTTON></FORM></BODY></HTML>




