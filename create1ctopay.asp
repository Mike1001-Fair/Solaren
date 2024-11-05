<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1;
if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

with (Request) {
    var ReportCharSet  = Form("ReportCharSet"),
	ReportCodePage = Form("ReportCodePage");
}

try {
	Solaren.SetCmd("List1Cexp");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, Session("UserId")));
		}
	}
	var rs = Solaren.Execute("List1Cexp", "Iнформацiю не знайдено");

	with (Cmd) {
		CommandText = "GetCompanyInfo";
		with (Parameters) {
			Append(CreateParameter("CompanyCode", adVarChar, adParamOutput, 10, ""));
			Append(CreateParameter("BudgetItem", adVarChar, adParamOutput, 10, ""));
		} Execute(adExecuteNoRecords);
	}

	Session("FileName") = "Export/1ctopay.tsv";
	var Period  = Month.GetPeriod(Session("OperMonth"), 1),
	CompanyCode = Cmd.Parameters.Item("CompanyCode").value,
	BudgetItem  = "\t" + Cmd.Parameters.Item("BudgetItem").value + "\t",	
	Today       = new Date(),
	dmy         = Today.toStr().formatDate("-"),
	Stream      = Server.CreateObject("ADODB.Stream"),
	fn          = Server.MapPath(Session("FileName"));

	with (Stream) {
		//Type    = 2;
		CharSet = ReportCharSet;
		Open();
	}
	
	for (; !rs.EOF; rs.MoveNext()) {
	    var CardText = rs.Fields("CardId").value.length > 0 ? ". Для поп КР " + rs.Fields("CardId").value + " " : " ",
		BegText  = rs.Fields("CustomerCode") + "\t" + rs.Fields("ContractPAN") + "\t" + dmy + "\t" ,
		EndText  = "\tкод-11011000" + BudgetItem,
		PurCost  = rs.Fields("PurCost").value.toFixed(2).replace(/\D/,","),
		Pdfo     = rs.Fields("Pdfo").value.toFixed(2).replace(/\D/,","),
		Vz       = rs.Fields("Vz").value.toFixed(2).replace(/\D/,",");
	    CardText += rs.Fields("CustomerName") + ", згiдно с.л. вiд " + dmy + ". Без ПДВ.";
	    var InfoLine = [
		BegText + "За вироблену е.е. в " + Period + CardText + BudgetItem + PurCost,
		BegText + "*;101;" + rs.Fields("CustomerCode") + ";прибутковий податок з " + rs.Fields("CustomerName") + EndText + Pdfo,
		BegText + "*;101;" + CompanyCode + ";вiйськовий збiр з " + rs.Fields("CustomerName") + " (" + rs.Fields("CustomerCode") + ")" + EndText + Vz + "\n"
	    ];
	    Stream.WriteText(InfoLine.join("\n"));
	} rs.Close();

	with (Stream) {
		SaveToFile(fn, 2);
		Close();
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex));
} finally {
	Connect.Close();
	Server.Execute("download.asp");
}%>