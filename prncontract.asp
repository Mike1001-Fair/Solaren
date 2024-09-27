<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/month.inc" -->
<% var Authorized = Session("RoleId") == 1,
ContractId = Request.Form("ContractId");

if (!Authorized) Solaren.SysMsg(2, "Помилка авторизації");

try {
	Solaren.SetCmd("GetContractInfo");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adInteger, adParamInput, 10, Session("UserId"))),
			Append(CreateParameter("ContractId", adInteger, adParamInput, 10, ContractId)),
			Append(CreateParameter("ContractPAN", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("ContractDate", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("ExpDate", adVarChar, adParamOutput, 10, "")),

			Append(CreateParameter("CustomerCode", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("CustomerName", adVarChar, adParamOutput, 40, "")),
			Append(CreateParameter("CustomerPhone", adVarChar, adParamOutput, 10, "")),
	
			Append(CreateParameter("CompanyRegion", adVarChar, adParamOutput, 20, 0)),
		        Append(CreateParameter("AreaName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("LocalityType", adTinyInt, adParamOutput, 10, 0)),
			Append(CreateParameter("LocalityName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("StreetType", adTinyInt, adParamOutput, 10, 0)),
			Append(CreateParameter("StreetName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("HouseId", adVarChar, adParamOutput, 20, "")),

		        Append(CreateParameter("ContractAreaName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("ContractLocalityName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("ContractStreetType", adTinyInt, adParamOutput, 10, 0)),
			Append(CreateParameter("ContractStreetName", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("ContractHouseId", adVarChar, adParamOutput, 20, "")),
			Append(CreateParameter("ContractPower", adCurrency, adParamOutput, 10, 0)),

			Append(CreateParameter("CardId", adVarChar, adParamOutput, 20, 0)),
			Append(CreateParameter("BankAccount", adVarChar, adParamOutput, 30, 0)),
			Append(CreateParameter("MfoCode", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("BankName", adVarChar, adParamOutput, 50, "")),

			Append(CreateParameter("CompanyName", adVarChar, adParamOutput, 60, "")),
			Append(CreateParameter("CompanyTown", adVarChar, adParamOutput, 20, "")),
			Append(CreateParameter("CompanyAdress", adVarChar, adParamOutput, 100, "")),
			Append(CreateParameter("CompanyPhone", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("CompanyCode", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("CompanyBank", adVarChar, adParamOutput, 100, "")),
			Append(CreateParameter("CompanyBankAccount", adVarChar, adParamOutput, 30, 0)),

			Append(CreateParameter("ChiefTitle", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("ChiefName", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("ChiefTitle2", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("ChiefName2", adVarChar, adParamOutput, 30, "")),
			Append(CreateParameter("TrustedDocId", adVarChar, adParamOutput, 10, "")),
			Append(CreateParameter("TrustedDocDate", adVarChar, adParamOutput, 10, "")),
			//Append(CreateParameter("ContractorName", adVarChar, adParamOutput, 20, "")),
			Append(CreateParameter("Phone", adVarChar, adParamOutput, 10, ""));
		} Execute(adExecuteNoRecords);

		with (Parameters) {
			var UserId   = Item("UserId").value,
			ContractId   = Item("ContractId").value,
			ContractPAN  = Item("ContractPAN").value,
			ContractDate = Item("ContractDate").value,
			ExpDate      = Item("ExpDate").value,

			CustomerCode  = Item("CustomerCode").value,
			CustomerName  = Item("CustomerName").value,
			CustomerPhone = Item("CustomerPhone").value,

			CompanyRegion = Item("CompanyRegion").value,
			AreaName      = Item("AreaName").value,
			LocalityType  = Item("StreetType").value,
			LocalityName  = Item("LocalityName").value,
			StreetType    = Item("StreetType").value,
			StreetName    = Item("StreetName").value,
			HouseId       = Item("HouseId").value,

			ContractAreaName     = Item("ContractAreaName").value,
			ContractLocalityName = Item("ContractLocalityName").value,
			ContractStreetType   = Item("ContractStreetType").value,
			ContractStreetName   = Item("ContractStreetName").value,
			ContractHouseId      = Item("ContractHouseId").value,
			ContractPower        = Item("ContractPower").value,

			CardId      = Item("CardId").value,
			BankAccount = Item("BankAccount").value,
			MfoCode     = Item("MfoCode").value,
			BankName    = Item("BankName").value,

			CompanyName        = Item("CompanyName").value,
			CompanyTown        = Item("CompanyTown").value,
			CompanyAdress      = Item("CompanyAdress").value,
			CompanyPhone       = Item("CompanyPhone").value,
			CompanyCode        = Item("CompanyCode").value,
			CompanyBank        = Item("CompanyBank").value,
			CompanyBankAccount = Item("CompanyBankAccount").value,

			ChiefTitle  = Item("ChiefTitle").value,
			ChiefName   = Item("ChiefName").value,
			ChiefTitle2 = Item("ChiefTitle2").value,
			ChiefName2  = Item("ChiefName2").value,

			TrustedDocId   = Item("TrustedDocId").value,
			TrustedDocDate = Item("TrustedDocDate").value,

			//ContractorName = Item("ContractorName").value,
			Phone          = Item("Phone").value;
		}
	}
} catch (ex) {
	Solaren.SysMsg(3, Solaren.GetErrMsg(ex))
} finally {	
	Connect.Close();
	Html.SetHead("Друк договору");

	AreaName = AreaName ? AreaName + " район," : "";
	ContractAreaName = ContractAreaName ? ContractAreaName + " район," : "";
	HouseId	+= ",";
	ContractHouseId += ",";
	LocalityName += ",";
	CompanyRegion += " область";

	var CustomerAddress = [Html.StreetType[StreetType], StreetName, HouseId, Html.LocalityType[LocalityType], LocalityName, AreaName, CompanyRegion],
	ContrtactAddress = [Html.StreetType[ContractStreetType], ContractStreetName, ContractHouseId, ContractLocalityName, ContractAreaName, CompanyRegion];

}%>
<STYLE>P {text-align: justify; line-height: 1.2; text-indent: 40px; margin: 5px 0px 0px 0px}
UL {list-style: disc; margin: 0px; line-height: 1.2; text-align: justify; }
LI {margin: 0px}</STYLE>
<BODY CLASS="PrnBody">

<TABLE CLASS="NoBorderTable" WIDTH="100%" STYLE="margin: 0px 0px 20px 0px">
<TR><TD ALIGN="LEFT" WIDTH="50%">&nbsp</TD><TD STYLE="font-size: 12px" ALIGN="LEFT" WIDTH="50%">Додаток 3 до договору про постачання електричної енергії  споживачу №<%=ContractPAN%></TD></TR>
<TR><TD ALIGN="CENTER" COLSPAN="2"><H3 STYLE="margin: 10px 0px 0px 0px">Договiр</H3></TD></TR>
<TR><TD ALIGN="CENTER" COLSPAN="2">про купiвлю-продаж електричної енергiї за "зеленим" тарифом приватним домогосподарством</TD></TR>
<TR><TD ALIGN="LEFT" WIDTH="50%"><%=CompanyTown%></TD><TD ALIGN="RIGHT" WIDTH="50%"><SUB><%=Month.GetDate(ContractDate, 2)%></SUB></TD></TR>
</TABLE>

<P><%=CompanyName%> в особi <%=ChiefTitle2 + ' '%><%=ChiefName2.replace(/ /g,"&nbsp")%>, дiючого на пiдставi Статуту (далі - Постачальник універсальних послуг), з однiєї сторони, та <B><%=CustomerName%></B>, 
що проживає за адресою: <%=CustomerAddress.join(" ")%> (далi – Споживач), з iншої сторони (далi - Сторони),
уклали договiр про купiвлю-продаж електричної енергiї за "зеленим" тарифом (далі - Договір) приватним домогосподарством, який є додатком до договору про постачання електричної енергії Постачальника універсальних
послуг за місцезнаходженням приватного домогосподарства Споживача, на якому електрична енергія використовується для задоволення побутових потреб. Місцезнаходження приватного домогосподарства:
<%=ContrtactAddress.join(" ")%> (далі - приватне домогосподарство).</P>
<P>Під час виконання умов цього договору сторони зобов'язуються діяти відповідно до чинного законодавства, Закону України "Про ринок електричної енергії", Кодексу комерційного обліку, Кодексу розподілу, Правил роздрібного ринку електричної енергії.</P>

<P><B>1. Предмет договору</B></P>
<P>За цим Договором Споживач має право продавати Постачальнику універсальних послуг електричну енергію, вироблену з енергії сонячного випромінювання та/або енергії вітру (необхідне підкреслити) об'єктами електроенергетики
(генеруючими установками) приватного домогосподарства, а постачальник універсальних послуг бере на себе зобов'язання купувати у Споживача електричну енергію за "зеленим" тарифом, встановленим НКРЕКП, в обсязі, що перевищує
місячне споживання електричної енергії приватним домогосподарством, у строки, передбачені цим Договором.</P>
<P>Постачальник універсальних послуг урегульовує взаємовідносини з побутовим споживачем щодо купівлі-продажу електричної енергії з дати улаштування засобу обліку, придатного до проведення розрахунків за "зеленим" тарифом,
та внесення інформації про приєднану генеруючу установку до паспорта точки розподілу (передачі) електричної енергії.</P>

<P><B>2. Права та обов’язки Сторiн</B></P>
<P>2.1. Постачальник унiверсальних послуг має право:
<UL><LI>тимчасово припиняти купiвлю виробленої генеруючою електроустановкою приватного домогосподарства електричної енергiї у разi виявлення постачальником послуг комерцiйного облiку та/або оператором системи пошкодження засобу
вимiрювальної технiки або його неправильної роботи, пошкодження або вiдсутностi пломб на ньому з вини Споживача;</LI>
<LI>надавати інформацію про послуги, пов'язані з купівлею електричної енергії.</LI></UL>

<P>2.2 Постачальник універсальних послуг  зобов'язаний:
<UL><LI>здійснювати отримання та обробку даних вузла обліку Споживача, отриманих від постачальника послуг комерційного обліку та/або оператора системи;
<LI>купувати у Споживача за "зеленим" тарифом, встановленим НКРЕКП, електричну енергію в обсязі, що перевищує місячне споживання електричної енергії приватним домогосподарством, на підставі Звітів про покази засобів обліку та Актів приймання-передавання товару (електричної енергії);
<LI>надавати Споживачу оформлені платіжні документи;
<LI>сплачувати Споживачу неустойку (пеню) у разі прострочення платежів за отриману електричну енергію.</UL></P>
<P>2.3. Споживач має право на:
<UL><LI>отримання плати за електричну енергiю, вироблену з енергiї сонячного випромiнювання об'єктами електроенергетики (генеруючими установками) приватного домогосподарства, за "зеленим" тарифом, вiдпущеної Постачальнику
унiверсальних послуг в обсязi, що перевищує мiсячне споживання електричної енергiї приватним домогосподарством;</LI>
<LI>відшкодування згідно із чинним законодавством збитків, заподіяних внаслідок порушення його прав;</LI>
<LI>оплату неустойки (пені) у разі прострочення платежів за отриману Постачальником універсальних послуг електричну енергію відповідно до умов та порядку оплати, визначених цим Договором;</LI>
<LI>здійснення контролю за правильністю оформлення Постачальником універсальних послуг платіжних документів.</LI></UL>
<P>2.4. Споживач зобов'язаний:
<UL><LI>продавати електричну енергію, вироблену генеруючою електроустановкою приватного домогосподарства понад власне споживання протягом розрахункового  періоду, Постачальнику універсальних послуг за "зеленим" тарифом;</LI>
<LI>дотримуватися вимог нормативно-технічних документів та цього договору;</LI>
<LI>забезпечувати належний технічний стан та безпечну експлуатацію електроустановок приватного домогосподарства, у тому числі генеруючих установок;</LI>
<LI>забезпечувати збереження засобів вимірювальної техніки і пломб на них у разі розміщення вузла обліку на території приватного домогосподарства;</LI>
<LI>допускати оператора системи розподілу для виконання заміни непрацюючого засобу обліку.</LI></UL>
<P><B>3. Вимiрювання та облiк електричної енергiї</B></P>
<P>3.1. Для розрахунків за вироблену (понад власне споживання приватним домогосподарством) електричну енергію використовується засіб (засоби) вимірювальної техніки, характеристики якого (яких) дозволяють одночасно обліковувати
обсяги відпущеної в електричну мережу та отриманої з електричної мережі електричної енергії або сальдо перетоків електричної енергії за календарний місяць. Вузол обліку має бути обладнаний пристроєм (вбудованим або зовнішнім
модемом GSM зв’язку), який забезпечує дистанційне зчитування даних для роботи в складі автоматизованої системи комерційного обліку електричної енергії постачальника послуг комерційного обліку (оператора системи).</P>
<P>3.2. Відомості про засіб (засоби) вимірювальної техніки електричної енергії, що використовується в розрахунках за цим договором, зазначаються в додатках до договору укладеного між Споживачем та Оператором системи про надання
послуг з розподілу.</P>
<P><B>4. Умови та порядок оплати</B></P>
<P>4.1. Розрахунковим періодом є календарний місяць. Оплата за продану електричну енергію, вироблену в обсязі, що перевищує місячне споживання електричної енергії приватним домогосподарством, здійснюється Постачальником універсальних
послуг до 15 числа місяця, наступного за розрахунковим, за умови підписання Споживачем не пізніше 07 числа місяця, наступного за розрахунковим звіту про покази засобу обліку вимірювальної техніки, обсяги та напрямки перетоків
прийнятої-переданої електричної енергії та акту прийому-передачі товару.</P>
<P>4.2 Постачальник універсальних послуг повинен перераховувати кошти для оплати проданої Споживачем електричної енергії, виробленої з енергії сонячного випромінювання генеруючою установкою приватного домогосподарства,
на поточний рахунок Споживача відповідно до заяви-повідомлення.</P>
<P>4.3. Величина "зеленого" тарифу затверджуються Регулятором та застосовуються Постачальником універсальних послуг відповідно до дати подачі та реєстрації заяви-повідомлення про встановлення генеруючої установки побутовим споживачем.</P>
<P>4.4. У разі зміни "зеленого" тарифу розрахунки за придбаний Постачальником універсальних послуг обсяг відпущеної приватним домогосподарством електричної енергії у мережу, що перевищує місячне споживання електричної енергії таким
приватним домогосподарством, здійснюються відповідно до встановленого НКРЕКП "зеленого" тарифу. Зміни "зеленого" тарифу не потребують внесення відповідних змін до цього Договору.</P>
<P>4.5. Термін дії "зеленого" тарифу та покладення спеціальних обов'язків із забезпечення збільшення частки виробництва електричної енергії з альтернативних джерел енергії на Постачальника універсальних послуг визначаються відповідно до закону.</P>
<P>4.6. Постачальник універсальних послуг щомісяця на основі отриманих показів засобу вимірювальної техніки не пізніше 06 числа місяця, наступного за розрахунковим, подає Споживачу для підпису звіт про покази засобу вимірювальної техніки,
обсяги та напрямки перетоків прийнятої-переданої електричної енергії. Якщо засіб вимірювальної техніки тимчасово не працює в складі автоматизованої системи комерційного обліку електричної енергії постачальника послуг комерційного обліку/та
або оператора системи, контрольне знімання показів засобу обліку проводиться постачальником послуг комерційного обліку та/або оператором системи щомісяця. Покази засобу вимірювальної техніки фіксуються в акті прийому-передачі товару
(електричної енергії), який складається в двох примірниках та підписується Споживачем і Постачальником універсальних послуг. За необхідності до акта додається роздруківка з пам'яті засобу вимірювальної техніки про обсяги та напрямки
перетоків електричної енергії за відповідний розрахунковий період.</P>
<P>4.7. У разі виявлення постачальником послуг комерційного обліку/та або оператором системи пошкодження засобу вимірювальної техніки, його неправильної роботи чи пошкодження або відсутності пломб на ньому з вини споживача, купівля електричної
енергії, виробленої з енергії сонячного випромінювання електроустановками приватного домогосподарства, припиняється з першого дня розрахункового періоду, в якому було виявлено порушення, та поновлюється з дати відновлення комерційного обліку
електричної енергії після усунення порушень.</P>
<P>4.8. Якщо порушення комерційного обліку електричної енергії в приватному домогосподарстві сталося не з вини Споживача, розрахунок виробленої генеруючою електроустановкою приватного домогосподарства, але не облікованої електричної енергії,
має здійснюватися відповідно до обсягів електричної енергії, виробленої у відповідному періоді попереднього року.</P>
<P>4.9. У разі відсутності даних за попередній рік розрахунок виробленої генеруючою електроустановкою приватного домогосподарства, але не облікованої електричної енергії, має здійснюватися Споживачем відповідно до обсягів, які були зафіксовані
в попередньому розрахунковому періоді.</P>
<P>4.10. У разі несплати з вини Постачальника універсальних послуг обсягу придбаної електричної енергії до 20 числа місяця, наступного за розрахунковим, Постачальник універсальних послуг зобов'язаний сплатити Споживачу пеню в розмірі подвійної
облікової ставки Національного банку, що діяла в період, за який сплачується пеня, від суми простроченого платежу за кожен день прострочення платежу.</P>

<P><B>5. Вiдповiдальнiсть Сторiн</B></P>
<P>5.1. Постачальник універсальних послуг несе відповідальність за:
<UL><LI>шкоду, заподіяну Споживачу або його майну, в розмірі і порядку, визначених відповідно до чинного законодавства;</LI>
<LI>прострочення з вини Постачальника універсальних послуг оплати за придбану електричну енергію;</LI>
<LI>порушення прав Споживача.</LI></UL></P>
<P>5.2. Постачальник універсальних послуг не несе відповідальності за шкоду, заподіяну Споживачу, якщо доведе, що шкода виникла з вини Споживача або внаслідок дії обставин непереборної сили.</P>
<P>5.3. Споживач несе відповідальність за:
<UL><LI>шкоду, заподіяну Постачальнику універсальних послуг або його майну, в розмірі і порядку, визначених відповідно до чинного законодавства;</LI>
<LI>порушення прав Постачальника універсальних послуг;</LI>
<LI>відмову в доступі до об'єкта Споживача відповідно до порядку, встановленого чинним законодавством та ПРРЕЕ;</LI>
<LI>пошкодження засобів обліку.</LI></UL></P>
<P>5.4. Споживач не несе відповідальності за шкоду, заподіяну Постачальнику універсальних послуг, якщо доведе, що шкода виникла з вини Постачальника універсальних послуг або внаслідок дії обставин непереборної сили.</P>
<P><B>6. Строк дiї Договору</B></P>
<P>Цей Договір набирає чинності з дати реєстрації Постачальником заяви-повідомлення та діє протягом дії договору про постачання електричної енергії споживачу, укладеного між Сторонами.</P>

<P><B>7. Порядок вирішення спорів</B></P>
<P>Спори, що можуть виникнути під час користування електричною енергією, якщо вони не будуть узгоджені шляхом переговорів між сторонами, вирішуються в судовому порядку.</P>
<P><B>8. Реквізити Сторін</B></P>

<UL STYLE="margin: 5px 0px;">
<U STYLE="margin: 5px 0px;">Постачальник унiверсальних послуг</U>: <%=CompanyName%>
<LI>Адреса: <%=CompanyAdress%></LI>
<LI>Телефон: <%=CompanyPhone%></LI>
<LI>Код ЄДРПОУ: <%=CompanyCode%></LI>
<LI>Банк: <%=CompanyBank%></LI>
<LI>Рахунок: <%=CompanyBankAccount%></LI></UL>

<UL STYLE="margin: 10px 0px 20px 0px">
<U>Споживач</U>: <%=CustomerName%>
<LI>Адреса: <%=CustomerAddress.join(" ")%></LI>
<LI>Телефон: <%=CustomerPhone%></LI>
<LI>ІПН: <%=CustomerCode%></LI>
<LI>Банк: <%=BankName%></LI>
<LI>Рахунок: <%=BankAccount%></LI></UL>

<TABLE WIDTH="100%">
<TR ALIGN="CENTER"><TD WIDTH="50%">Постачальник унiверсальних послуг:</TD><TD WIDTH="50%">Споживач:</TD></TR>
<TR ALIGN="CENTER"><TD STYLE="padding: 10px 0px 0px 0px"><%=ChiefTitle%><BR><%=ChiefName%></TD><TD><%=CustomerName%></TD></TR>
<TR ALIGN="CENTER"><TD><DIV CLASS="UnderLine"></TD>
<TD><DIV CLASS="UnderLine"></DIV></TD></TR>
</TABLE></BODY></HTML>