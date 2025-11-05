<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId > 0 && User.RoleId < 3;
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListIndicator");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("ContractId", adVarChar, adParamInput, 10, Form.ContractId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, Form.BegDate));
			Append(CreateParameter("EndDate", adVarChar, adParamInput, 10, Form.EndDate));
		}
	}
	var rs = Solaren.Execute("ListIndicator");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Показники лiчильника");
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("editindicator.asp?IndicatorId=", rs.Fields("Id"), rs.Fields("ReportDate")),
			td = [Tag.Write("TD", -1, rs.Fields("MeterCode")),
				Tag.Write("TD", -1, url),
				Tag.Write("TD", 2, rs.Fields("RecVal").Value.toDelimited(0)),
				Tag.Write("TD", 2, rs.Fields("RetVal").Value.toDelimited(0))		
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
		var rows = this.GetRows(rs),
		Header = ['Номер', 'Дата', 'Прийом', 'Видача'],
		Body = ['<BODY CLASS="MainBody">',
			'<TABLE CLASS="H3Text">',
			Tag.Write("CAPTION", -1, Html.Title),
			'<TR><TD ALIGN="RIGHT">Споживач:</TD><TD ALIGN="LEFT">' + Form.ContractName + '</TD></TR>',
			'</TABLE>',
			'<TABLE CLASS="InfoTable">',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(Header.length, rows.length)
		];
		return Body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>


