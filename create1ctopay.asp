<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/upsert.set" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/datastream.inc" -->
<% var Authorized = User.RoleId == 1,
Form = Solaren.Parse();
User.CheckAccess(Authorized, "POST");

try {
	Solaren.SetCmd("List1Cexp");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("List1Cexp"),
	rsCompanyInfo = Solaren.Execute("GetCompanyInfo");
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	Session("FileName") = "Export/1ctopay.tsv";
}

var Report = {
	Write: function(rs) {
		var Period  = Month.GetPeriod(Month.GetMonth(1), 1),
		CompanyCode = rsCompanyInfo.Fields("CompanyCode").Value,	
		BudgetItem  = "\t" + rsCompanyInfo.Fields("BudgetItem").Value + "\t",	
		dmy         = Month.Today.toStr(0).formatDate("-"),
		fn          = Server.MapPath(Session("FileName"));
		DataStream.Open(Form.ReportCharSet, 2);
		for (; !rs.EOF; rs.MoveNext()) {
			var Block = [],
			CardText  = rs.Fields("CardId").Value.length > 0 ? ". Для поп КР " + rs.Fields("CardId").Value + " " : " ",
			BegText   = rs.Fields("CustomerCode") + "\t" + rs.Fields("ContractPAN") + "\t" + dmy + "\t" ,
			EndText   = "\tкод-11011000" + BudgetItem,
			PurCost   = rs.Fields("PurCost").Value.toFixed(2).replace(/\D/, ","),
			Pdfo      = rs.Fields("Pdfo").Value.toFixed(2).replace(/\D/, ","),
			Vz        = rs.Fields("Vz").Value.toFixed(2).replace(/\D/, ",");

			CardText += rs.Fields("CustomerName") + ", згiдно с.л. вiд " + dmy + ". Без ПДВ.";

			var Line = [
				["За вироблену е.е. в ", Period, CardText, BudgetItem, PurCost],
				["*;101;", rs.Fields("CustomerCode"), ";прибутковий податок з ", rs.Fields("CustomerName"), EndText, Pdfo],
				["*;101;", CompanyCode, ";вiйськовий збiр з ", rs.Fields("CustomerName"), " (", rs.Fields("CustomerCode"), ")", EndText, Vz]
			];
		
			for (var i = 0; i < Line.length; i++) {
				Block.push(BegText + Line[i].join(""));
			}
			Stream.WriteText(Block.join("\n"));
		}
		Stream.SaveToFile(fn, 2);
	}
}
	
Report.Write(rs);
rsCompanyInfo.Close();
rs.Close();
Stream.Close();
Solaren.Close();
Server.Execute("download.asp");
%>