<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Include/list.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("ListContract");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
			Append(CreateParameter("CustomerId", adVarChar, adParamInput, 10, Form.CustomerId));
			Append(CreateParameter("PAN", adVarChar, adParamInput, 10, Form.PAN));
		}
	}
	var rs = Solaren.Execute("ListContract");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	Html.SetPage("Список договорiв")
}

var Table = {
	TotPower: 0,
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF; rs.MoveNext()) {
			var ContractAddress = [Locality.Type[rs.Fields("LocalityType")],
				rs.Fields("LocalityName") + ",",
				Street.Type[rs.Fields("StreetType")],
				rs.Fields("StreetName"),
				rs.Fields("HouseId")
			],
			url = Html.GetLink("editcontract.asp?ContractId=", rs.Fields("ContractId"), rs.Fields("PAN")),
            td = [Tag.Write("TD", -1, url),
				Tag.Write("TD", 0, rs.Fields("CustomerName")),
				Tag.Write("TD", -1, ContractAddress.join(" ")),
				Tag.Write("TD", -1, rs.Fields("ContractDate")),
				Tag.Write("TD", -1, rs.Fields("BranchName")),
				Tag.Write("TD", 2, rs.Fields("ContractPower").Value.toDelimited(1))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotPower += rs.Fields("ContractPower"); 			
		}
		return rows;
	},

	Render: function(rs) {
        var rows = this.GetRows(rs),
		Header = ['Рахунок', 'Споживач', 'Адреса', 'Дата', 'ЦОС', 'Потужнiсть'],
		footer = ['<TH ALIGN="LEFT" COLSPAN="5">Всього: ', rows.length,'</TH>',
			Tag.Write("TH", 2, this.TotPower.toDelimited(1))
		],
		body = [
			'<BODY CLASS="MainBody">',
			'<H3 CLASS="H3Text">' + Html.Title + '</H3>',
			'<TABLE CLASS="InfoTable">',
			Html.GetHeadRow(Header),
			rows.join("\n"),
			Tag.Write("TR", -1, footer.join(""))
        ];
        return body.join("\n");
	}
},
Output = Table.Render(rs);

rs.Close();
Solaren.Close();
Response.Write(Output)%>