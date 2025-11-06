<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");
	
try {
	Solaren.SetCmd("ListTarif");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("GroupId", adVarChar, adParamInput, 10, Form.GroupId));
			Append(CreateParameter("BegDate", adVarChar, adParamInput, 10, Form.BegDate));
		}
	}
	var rs = Solaren.Execute("ListTarif");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список тарифiв")
}

var Table = {
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var url = Html.GetLink("edittarif.asp?TarifId=", rs.Fields("Id"), rs.Fields("Tarif").Value.toDelimited(2)),
			BegDate = Month.GetYMD(rs.Fields("BegDate").Value),
			EndDate = Month.GetYMD(rs.Fields("EndDate").Value),
			ExpDateBeg = Month.GetYMD(rs.Fields("ExpDateBeg").Value),
			ExpDateEnd = Month.GetYMD(rs.Fields("ExpDateEnd").Value),
			range = Month.GetRange(ExpDateBeg, ExpDateEnd),
			td = [Tag.Write("TD", -1, BegDate.formatDate("-")),
				Tag.Write("TD", -1, EndDate.formatDate("-")),
				Tag.Write("TD", -1, range),
				Tag.Write("TD", 2, url)
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
		}
		return rows;
	},

	Render: function(rs) {
        var rows = this.GetRows(rs),
		Header = ['з', 'по', 'коп'],
		body = [
			'<BODY CLASS="MainBody">',
			'<H3 CLASS="H3Text">Список тарифiв<SPAN>Група: ' + Form.GroupName + '</SPAN></H3>',
			'<TABLE CLASS="InfoTable">',
			'<TR><TH COLSPAN="2">Дiє</TH><TH ROWSPAN="2">Дата вводу в<BR>експлуатацiю</TH><TH>Тариф</TH></TR>',
 			Html.GetHeadRow(Header),
			rows.join("\n"),
			Html.GetFooterRow(4, rows.length)
		];
        return body.join("\n");
	}
},
Output = Table.Render(rs);
rs.Close();
Solaren.Close();
Response.Write(Output)%>