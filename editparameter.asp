<%@ LANGUAGE = "JavaScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/edit.set" -->
<% var Authorized = !Solaren.Empty(User.RoleId) && User.RoleId >= 0 && User.RoleId < 2;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("GetParameter");
	var rs = Solaren.Execute("GetParameter");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	var List = {
		NewIndicator: "Нові показники",
		CheckCard   : "Перевіряти картку",
		ShowDeleted : "Показувати видалене"
	},
	Record = Solaren.Map(rs.Fields);
	rs.Close();
	Solaren.Close();
	Html.SetPage("Параметри");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditParameter" ACTION="updateparameter.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="SysConfig" VALUE="<%=Record.SysConfig%>">
<H3 CLASS="HeadText" ID="H3Id"><IMG SRC="Images/gearGreen.svg"><%=Html.Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Старт</TD>
	<TD><INPUT TYPE="date" NAME="StartSysDate" VALUE="<%=Record.StartSysDate%>" MIN="<%=Month.Date[0]%>" MAX="<%=Month.Date[4]%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Місяць</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=Record.OperMonth%>" MIN="<%=Month.GetMonth(0)%>" MAX="<%=Month.GetMonth(3)%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Лiмiт годин доби</TD>
	<TD><INPUT TYPE="Number" NAME="HoursLimit" VALUE="<%=Record.HoursLimit%>" STEP="1" MIN="5" MAX="12" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Довжина рахунку</TD>
	<TD><INPUT TYPE="Number" NAME="PanLimit" VALUE="<%=Record.PanLimit%>" STEP="1" MIN="9" MAX="9" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Стаття бюджету</TD>
	<TD><INPUT TYPE="text" NAME="BudgetItem" VALUE="<%=Record.BudgetItem%>" SIZE="8" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TABLE>
	</FIELDSET>

	<FIELDSET><LEGEND>Реквізити ВЗ</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Отримувач</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryName" VALUE="<%=Record.TreasuryName%>" SIZE="30" MAXLENGTH="30" TITLE="Вiйськовий збiр"></TD></TR>
	<TR><TD ALIGN="RIGHT">ЄДРПОУ</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryCode" VALUE="<%=Record.TreasuryCode%>" SIZE="10" MAXLENGTH="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryAccount" VALUE="<%=Record.TreasuryAccount%>" SIZE="30" MAXLENGTH="29"></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryMfo" VALUE="<%=Record.TreasuryMfo%>" SIZE="10" MAXLENGTH="10"></TD></TR></TABLE>
	</FIELDSET>

	<% Config.Write(List) %>

	<FIELDSET ALIGN="CENTER">
	<LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="ShowMsg" ID="ShowMsg"<%=Record.ShowMsg ? " CHECKED" : ""%>>Повiдомлення</LABEL></LEGEND>
	<TEXTAREA CLASS="MsgArea" NAME="MsgText" ROWS="4" COLS="43" maxLength="400"><%=Record.MsgText%></TEXTAREA>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(0)%>
</FORM></BODY></HTML>
