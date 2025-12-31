<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse(),
BegDate = String(Form.BegDate),
EndDate = String(Form.EndDate),
Period  = Month.GetRange(BegDate, EndDate);
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListAppLog");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, EndDate));
			Append(CreateParameter("EventType", adVarChar, adParamInput, 10, Form.EventType));
		}
	}
	var rs = Solaren.Execute("ListAppLog");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Журнал")
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var td = [Tag.Write("TD", -1, rs.Fields("EventDate")),
				Tag.Write("TD", -1, rs.Fields("EventText"))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);			
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['Дaта', 'Повідомлення'],
		body = ['<BODY CLASS="MainBody">',
			'<TABLE CLASS="H3Text">',
			'<CAPTION>Журнал</CAPTION>',
			'<TR><TD ALIGN="RIGHT">Подія:</TD><TD ALIGN="LEFT">' + Form.EventName + '</TD></TR>',
			'<TR><TD ALIGN="RIGHT">Період:</TD><TD ALIGN="LEFT">' + Period + '</TD></TR>',
			'</TABLE>',
			'<TABLE CLASS="InfoTable">',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(Header.length, rows.length)
		];
		return body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>


