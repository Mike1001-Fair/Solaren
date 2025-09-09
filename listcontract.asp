<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<!-- #INCLUDE FILE="Include/locality.inc" -->
<!-- #INCLUDE FILE="Include/street.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();

User.ValidateAccess(Authorized, "POST");

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
	Header: ['Рахунок', 'Споживач', 'Адреса', 'Дата', 'ЦОС', 'Потужнiсть'],
	TotPower: 0,
	GetRows: function(rs) {
		for (var rows = []; !rs.EOF;) {
			var ContractAddress = [Locality.Type[rs.Fields("LocalityType")],
				rs.Fields("LocalityName") + ",",
				Street.Type[rs.Fields("StreetType")],
				rs.Fields("StreetName"),
				rs.Fields("HouseId")
			],
			url = url = Html.GetLink("editcontract.asp?ContractId=", rs.Fields("ContractId"), rs.Fields("PAN")),
            td = [Tag.Write("TD", -1, url),
				Tag.Write("TD", 0, rs.Fields("CustomerName")),
				Tag.Write("TD", -1, ContractAddress.join(" ")),
				Tag.Write("TD", -1, rs.Fields("ContractDate")),
				Tag.Write("TD", -1, rs.Fields("BranchName")),
				Tag.Write("TD", 2, rs.Fields("ContractPower").value.toDelimited(1))
			],
			tr = Tag.Write("TR", -1, td.join(""));
			rows.push(tr);
			this.TotPower += rs.Fields("ContractPower");
 			rs.MoveNext();
		}
		return rows;
	},

	Render: function(rs) {
        var rows = this.GetRows(rs),
		th = ['<TH ALIGN="LEFT" COLSPAN="5">Всього: ', rows.length,'</TH>',
			Tag.Write("TH", 2, this.TotPower.toDelimited(1))
		],
		body = [
            '<BODY CLASS="MainBody">',
            '<H3 CLASS="H3Text">' + Html.Title + '</H3>',
            '<TABLE CLASS="InfoTable">',
            Html.GetHeadRow(this.Header),
            rows.join("\n"),
			Tag.Write("TR", -1, th.join(""))
        ];
        return body.join("\n");
	}
},
Output = Table.Render(rs);

rs.Close();
Solaren.Close();
Response.Write(Output)%>