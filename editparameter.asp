<%@ LANGUAGE = "JavaScript"%> 
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/config.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
List = {
	NewIndicator: "Нові показники",
	CheckCard   : "Перевіряти картку",
	ShowDeleted : "Показувати видалене"
};

User.ValidateAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetParameter");
	var rs = Solaren.Execute("GetParameter");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var Parameter = Solaren.Map(rs.Fields);
	rs.Close();
	Solaren.Close();
	Html.SetPage("Параметри");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditParameter" ACTION="updateparameter.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="SysConfig" VALUE="<%=Parameter.SysConfig%>">
<H3 CLASS="HeadText" ID="H3Id"><IMG SRC="Images/gearGreen.svg"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Старт</TD>
	<TD><INPUT TYPE="date" NAME="StartSysDate" VALUE="<%=Parameter.StartSysDate%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Місяць</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=Parameter.OperMonth%>" MIN="<%=Month.GetMonth(0)%>" MAX="<%=Month.GetMonth(3)%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Лiмiт годин доби</TD>
	<TD><INPUT TYPE="Number" NAME="HoursLimit" VALUE="<%=Parameter.HoursLimit%>" STEP="1" MIN="5" MAX="12" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Довжина рахунку</TD>
	<TD><INPUT TYPE="Number" NAME="PanLimit" VALUE="<%=Parameter.PanLimit%>" STEP="1" MIN="9" MAX="9" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Стаття бюджету</TD>
	<TD><INPUT TYPE="text" NAME="BudgetItem" VALUE="<%=Parameter.BudgetItem%>" SIZE="8" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TABLE>
	</FIELDSET>

	<FIELDSET><LEGEND>Реквізити ВЗ</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Отримувач</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryName" VALUE="<%=Parameter.TreasuryName%>" SIZE="30" MAXLENGTH="30" TITLE="Вiйськовий збiр"></TD></TR>
	<TR><TD ALIGN="RIGHT">ЄДРПОУ</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryCode" VALUE="<%=Parameter.TreasuryCode%>" SIZE="10" MAXLENGTH="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryAccount" VALUE="<%=Parameter.TreasuryAccount%>" SIZE="30" MAXLENGTH="29"></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryMfo" VALUE="<%=Parameter.TreasuryMfo%>" SIZE="10" MAXLENGTH="10"></TD></TR></TABLE>
	</FIELDSET>

	<% Config.Write(List) %>

	<FIELDSET ALIGN="CENTER">
	<LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="ShowMsg" ID="ShowMsg"<%=Parameter.ShowMsg ? " CHECKED" : ""%>>Повiдомлення</LABEL></LEGEND>
	<TEXTAREA CLASS="MsgArea" NAME="MsgText" ROWS="4" COLS="43" maxLength="400"><%=Parameter.MsgText%></TEXTAREA>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(0)%>
</FORM></BODY></HTML>
