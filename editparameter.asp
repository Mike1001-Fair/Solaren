<%@ LANGUAGE = "JavaScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<% var Authorized = Session("RoleId") >= 0 && Session("RoleId") < 2;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

function SysCfgWrite() {	
	var ResponseText = '<FIELDSET NAME="SysCfgSet"><LEGEND>Додаткові</LEGEND>\n',
	SysCfg = {
		NewIndicator: "Нові показники",
		CheckCard   : "Перевіряти картку",
		ShowDeleted : "Показувати видалене"
	};

	for (var key in SysCfg) {
		var LabelRow = ['<LABEL CLASS="BlockLabel"><INPUT TYPE="CheckBox" NAME="', key, '">', SysCfg[key], '</LABEL>\n'];
		ResponseText += LabelRow.join("");
	}
	ResponseText +=	'</FIELDSET>';
	Response.Write(ResponseText);
}

try {
	Solaren.SetCmd("GetParameter");
	var rs = Solaren.Execute("GetParameter", "Iнформацiю не знайдено");
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	with (rs) {
		var StartSysDate = Fields("StartSysDate").value,
		OperMonth        = Fields("OperMonth").value,
		HoursLimit       = Fields("HoursLimit").value,
		PanLimit         = Fields("PanLimit").value,
		BudgetItem	 = Fields("BudgetItem").value,
		TreasuryName	 = Fields("TreasuryName").value,
		TreasuryCode	 = Fields("TreasuryCode").value,
		TreasuryAccount	 = Fields("TreasuryAccount").value,
		TreasuryMfo	 = Fields("TreasuryMfo").value,
		SysConfig        = Fields("SysConfig").value,
		ShowMsg          = Fields("ShowMsg").value,
		MsgText          = Fields("MsgText").value,
		Title            = "Параметри";
		Close();
	}
	Connect.Close();
}

with (Html) {
	SetHead(Title);
	WriteScript();
	WriteMenu(Session("RoleId"), 0);
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditParameter" ACTION="updateparameter.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="SysConfig" VALUE="<%=SysConfig%>">
<H3 CLASS="HeadText" ID="H3Id"><IMG SRC="Images/gearGreen.svg"><%=Title%></H3>

<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Загальні</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Старт</TD>
	<TD><INPUT TYPE="date" NAME="StartSysDate" VALUE="<%=StartSysDate%>" MIN="<%=Html.MinDate%>" MAX="<%=Html.MaxDate%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Місяць</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=OperMonth%>" MIN="<%=Html.LimitMonth(0)%>" MAX="<%=Session("NextDate").slice(0, 7)%>" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Лiмiт годин доби</TD>
	<TD><INPUT TYPE="Number" NAME="HoursLimit" VALUE="<%=HoursLimit%>" STEP="1" MIN="5" MAX="12" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Довжина рахунку</TD>
	<TD><INPUT TYPE="Number" NAME="PanLimit" VALUE="<%=PanLimit%>" STEP="1" MIN="9" MAX="9" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Стаття бюджету</TD>
	<TD><INPUT TYPE="text" NAME="BudgetItem" VALUE="<%=BudgetItem%>" SIZE="8" MAXLENGTH="8" PATTERN="\d{8}" REQUIRED></TD></TABLE>
	</FIELDSET>

	<FIELDSET><LEGEND>Реквізити ВЗ</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Отримувач</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryName" VALUE="<%=TreasuryName%>" SIZE="30" MAXLENGTH="30" TITLE="Вiйськовий збiр"></TD></TR>
	<TR><TD ALIGN="RIGHT">ЄДРПОУ</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryCode" VALUE="<%=TreasuryCode%>" SIZE="10" MAXLENGTH="10"></TD></TR>
	<TR><TD ALIGN="RIGHT">Рахунок</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryAccount" VALUE="<%=TreasuryAccount%>" SIZE="30" MAXLENGTH="29"></TD></TR>
	<TR><TD ALIGN="RIGHT">МФО</TD>
	<TD><INPUT TYPE="text" NAME="TreasuryMfo" VALUE="<%=TreasuryMfo%>" SIZE="10" MAXLENGTH="10"></TD></TR></TABLE>
	</FIELDSET>

	<% SysCfgWrite() %>

	<FIELDSET ALIGN="CENTER">
	<LEGEND><LABEL><INPUT TYPE="CheckBox" NAME="ShowMsg" ID="ShowMsg"<%=ShowMsg ? " CHECKED" : ""%>>Повiдомлення</LABEL></LEGEND>
	<TEXTAREA CLASS="MsgArea" NAME="MsgText" ROWS="4" COLS="43" maxLength="400"><%=MsgText%></TEXTAREA>
	</FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(0)%>
</FORM></BODY></HTML>