<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/httpclient.inc" -->
<!-- #INCLUDE FILE="Include/email.inc" -->
<!-- #INCLUDE FILE="Include/prototype.inc" -->
<% with (Html) {
	SetHead("Повідомлення");
}
/*var StartDate = "2024-09-33";
Response.Write(StartDate.isDate() + "<br>");
Response.Write(StartDate.toDate());*/
//var url = "https://bitpay.com/api/rates/";
//var url = "https://openexchangerates.org/api/latest.json?app_id=289431ee138248028f54e7df93d2e5b3";
var url = "https://kresc.com.ua/complaints/submit/";
//var url = "https://cashier4you.globalsecurepayment.net/createcustomer.asp?Sportsbook=Red+Dog+Casino+EUR&SecurePasscode=Zzyhrr&PIN=Test1001001&CustName=BlueAngel001 May&Street=BroadWay&City=NewYork&Country=gb&Phone=0123456789&Email=test1001@mail.ru&DOB=2000/01/01&Gender=M";

for (var i=0; i<10; i++) {
	Response.Write('<P>i=' + i + '</P>');
	FXRate.GetExchangeRate(url);
}
//Email.SetConfig();
//Email.WriteConfig();
//Email.Send("nickchernov@gmail.com", "Test", "Test");
%>


