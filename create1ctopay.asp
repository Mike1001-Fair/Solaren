<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/referer.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/datastream.inc" -->
<% var Authorized = User.RoleId == 1;
User.ValidateAccess(Authorized, "POST");

with (Request) {
	var ReportCharSet = Form("ReportCharSet"),
	ReportCodePage = Form("ReportCodePage");
}

try {
	Solaren.SetCmd("List1Cexp");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}
	var rs = Solaren.Execute("List1Cexp"),
	rsCompanyInfo = Solaren.Execute("GetCompanyInfo");

	Session("FileName") = "Export/1ctopay.tsv";

	var Period  = Month.GetPeriod(Month.GetMonth(1), 1),
	CompanyCode = rsCompanyInfo.Fields("CompanyCode").value,	
	BudgetItem  = "\t" + rsCompanyInfo.Fields("BudgetItem").value + "\t",	
	Today       = new Date(),
	dmy         = Today.toStr(0).formatDate("-"),
	fn          = Server.MapPath(Session("FileName"));

	DataStream.Open(ReportCharSet, 2);
	
	for (; !rs.EOF; rs.MoveNext()) {
		var Block = [],
		CardText  = rs.Fields("CardId").value.length > 0 ? ". Для поп КР " + rs.Fields("CardId").value + " " : " ",
		BegText   = rs.Fields("CustomerCode") + "\t" + rs.Fields("ContractPAN") + "\t" + dmy + "\t" ,
		EndText   = "\tкод-11011000" + BudgetItem,
		PurCost   = rs.Fields("PurCost").value.toFixed(2).replace(/\D/, ","),
		Pdfo      = rs.Fields("Pdfo").value.toFixed(2).replace(/\D/, ","),
		Vz        = rs.Fields("Vz").value.toFixed(2).replace(/\D/, ",");

		CardText += rs.Fields("CustomerName") + ", згiдно с.л. вiд " + dmy + ". Без ПДВ.";

		var Line = [
			["За вироблену е.е. в ", Period, CardText, BudgetItem, PurCost],
			["*;101;", rs.Fields("CustomerCode"), ";прибутковий податок з ", rs.Fields("CustomerName"), EndText, Pdfo],
			["*;101;", CompanyCode, ";вiйськовий збiр з ", rs.Fields("CustomerName"), " (", rs.Fields("CustomerCode"), ")", EndText, Vz]
		];
		
		for (var i = 0; i < Line.length; i++) {
			Block.push(BegText + Line[i].join("") + "\n");
		}

		Stream.WriteText(Block.join(""));
	}
	Stream.SaveToFile(fn, 2);
} catch (ex) {
	Message.Write(3, Message.Error(ex));
} finally {
	rsCompanyInfo.Close();
	rs.Close();
	Stream.Close();
	Solaren.Close();
	Server.Execute("download.asp");
}%>

