
<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("ListNoPurVol");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("OperDate", adVarChar, adParamInput, 10, Month.Date[1]));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

if (rs.EOF) {
	rs.Close();
	Solaren.Close();
	Message.Write(1, "Помилок не виявлено");
} else {
	var OperDate = Month.GetMonth(1),
	Period = Month.Flip(OperDate),
	Header = ['Споживач', 'Рахунок', 'З', 'По', 'Прийом', 'Видача', 'ЦОС'],
	ResponseText = ['<BODY CLASS="MainBody">',
		'<H3 CLASS="H3Text">Перевiрка обсягiв<SPAN>перiод: ' + Period + '</SPAN></H3>',
		'<TABLE CLASS="InfoTable">',
		Html.GetHeadRow(Header)
	];

	for (var i=0; !rs.EOF; i++) {
		var td = [Tag.Write("TD", -1, rs.Fields("CustomerName")),
			Tag.Write("TD", -1, rs.Fields("ContractPAN")),
			Tag.Write("TD", -1, rs.Fields("BegDate")),
			Tag.Write("TD", -1, rs.Fields("EndDate")),
			Tag.Write("TD", 2, rs.Fields("RecVol").value.toDelimited(0)),
			Tag.Write("TD", 2, rs.Fields("RetVol").value.toDelimited(0)),
			Tag.Write("TD", -1, rs.Fields("BranchName"))
		],
		tr = Tag.Write("TR", -1, td.join(""));
		ResponseText.push(tr);
		rs.MoveNext();
	}
	rs.Close();
	Solaren.Close();
	ResponseText.push(Html.GetFooterRow(7, i));
	Html.SetPage("Обсяги")
	Response.Write(ResponseText.join("\n"))
}%>
