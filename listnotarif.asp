<%@ LANGUAGE = "JScript"%>
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->

<% var Authorized = User.RoleId == 1;
User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("ListNoTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Cmd.Execute();
} catch (ex) {
	Message.Write(3, Message.Error(ex))
}

if (rs.EOF) {
	Message.Write(1, "Помилок не виявлено");
} else {
	with (Html) {
		SetHead("Обсяги");
		Menu.Write(Session("RoleId"), 0);
	}
	var Header = ['Споживач', 'Рахунок', 'З', 'По', 'Обсяг<BR>кВт&#183;год', 'Вартiсть<BR>грн', 'ЦОС'],
	ResponseText = ['<BODY CLASS="MainBody">',
		'<H3 CLASS="H3Text">Перевiрка тарифу</H3>',
		'<TABLE CLASS="InfoTable">',
		Html.GetHeadRow(Header)
	];

	for (var i=0; !rs.EOF; i++) {
		td = [Tag.Write("TD", -1, rs.Fields("CustomerName")),
			Tag.Write("TD", -1, rs.Fields("ContractPAN")),
			Tag.Write("TD", -1, rs.Fields("BegDate")),
			Tag.Write("TD", -1, rs.Fields("EndDate")),
			Tag.Write("TD", 2, rs.Fields("PurVol").Value.toDelimited(0)),
			Tag.Write("TD", 2, rs.Fields("VolCost").Value.toDelimited(2)),
			Tag.Write("TD", -1, rs.Fields("BranchName")),
		],
		tr = Tag.Write("TR", -1, td.join(""));
		ResponseText.push(tr);
		rs.MoveNext();
	}
	rs.Close();
	Solaren.Close();
	ResponseText.push(Html.GetFooterRow(7, i));
	Response.Write(ResponseText.join("\n"))
}%>


