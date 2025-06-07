<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.Authorize(1)) {
	Message.Write(2, Dictionary.Item("AuthorizationError"))
}%>
<NAV class="nav">
	<UL class="topmenu">
		<LI><A href="#" ID="LogOut">&#x23F9;<%=Dictionary.Item("Logout")%></A></LI>
		<LI><%=Dictionary.Item("Work")%>
		<UL class="submenu">
			<LI><A href="#">Обсяг</A>
			<UL class="submenu">
				<LI><A href="findvol.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newfactvol.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="newimport.asp">Iмпорт</A></LI>
			<LI><A href="#">Оплата</A>
			<UL class="submenu">
				<LI><A href="findpay.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newpay.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI><A href="findapplog.asp">Журнал</A></LI>

			<LI><A href="#">Замовлення</A>
			<UL class="submenu">
				<LI><A href="findorder.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="neworder.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI class="divider"><A href="newexport.asp">Експорт</A></LI>

			<LI><A href="#">Показники</A>
			<UL class="submenu">
				<LI><A href="findindicator.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>
			<LI><A href="editparameter.asp">Параметри</A></LI>
			<LI><A href="#">Перерахунок</A>
			<UL class="submenu">
				<LI><A href="findoper.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newoper.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI class="divider"><A href="newconsolidation.asp">Консолiдацiя</A></LI>
			<LI><A href="listnopurvol.asp">Перевiрка обсягiв</A></LI>
			<LI><A href="listnotarif.asp">Перевiрка тарифу</A></LI>
			<LI><A href="listnovol.asp">Договора без обсягiв</A></LI>
			<LI class="divider"><A href="newmonth.asp">Закриття мicяця</A></LI>
		</UL></LI>
		<LI><%=Dictionary.Item("Reports")%>
		<UL class="submenu">
			<LI><A href="findregistry.asp">Реєстр</A></LI>
			<LI><A href="findfactvol.asp">Обсяги</A></LI>
			<LI><A href="findbalance.asp">Баланс</A></LI>
			<LI><A href="findsov.asp">Сальдовка</A></LI>
			
			<LI class="divider"><A href="findcompensation.asp">Компенсація</A></LI>
			<LI><A href="findbudgetcode.asp">Бюджетний код</A></LI>
			<!--LI><A href="findoperatoract.asp">Акт звірки ОСР</A></LI-->
			<LI><A href="findbranchact.asp">Перевірка актів</A></LI>

			<LI class="divider"><A href="findnote.asp">Службовий лист</A></LI>
			<LI><A href="findvolrem.asp">Вартicть по ЦОС</A></LI>
			<LI><A href="findvolpay.asp">Енергозбереження</A></LI>
			<LI><A href="findcontractcount.asp">Кiлькiсть договорiв</A></LI>

			<LI class="divider"><A href="findhistory.asp">Iсторiя розрахункiв</A></LI>
			<LI><A href="findtarifvol.asp">Обсяги по тарифам</A></LI>
			<LI><A href="findvolcost.asp">Вартicть по споживачу</A></LI>
			<LI><A href="findsalesreport.asp">Звіт по продажам</A></LI>
		</UL></LI>
		<LI><%=Dictionary.Item("Directories")%>
		<UL class="submenu">
			<LI><A href="#"><%=Dictionary.Item("Branches")%></A>
			<UL class="submenu">
				<LI><A href="findbranch.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>
			<LI><A href="#">РЕМ</A>
			<UL class="submenu">
				<LI><A href="findaen.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newaen.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
                        <LI><A href="#">Банки</A>
			<UL class="submenu">
				<LI><A href="findbank.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newbank.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Оператори</A>
			<UL class="submenu">
				<LI><A href="findoperator.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newoperator.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>

			<LI class="divider"><A href="#">Вулиці</A>
			<UL class="submenu">
				<LI><A href="findstreet.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newstreet.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
			<LI><A href="#">Пункти</A>
			<UL class="submenu">
				<LI><A href="findlocality.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newlocality.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Райони</A>
				<UL class="submenu">
					<LI><A href="findarea.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newarea.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#">Області</A>
				<UL class="submenu">
					<LI><A href="findregion.asp"><%=Dictionary.Item("Search")%></A>
					<LI><A href="newregion.asp"><%=Dictionary.Item("New2")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Countries")%></A>
			<UL class="submenu">
				<LI><A href="findcountry.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newcountry.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI class="divider"><A href="#">Посади</A>
			<UL class="submenu">
				<LI><A href="findchieftitle.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newchieftitle.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
			<LI><A href="findcompany.asp">Компанія</A>
			<LI><A href="#">Керiвники</A>
			<UL class="submenu">
				<LI><A href="findchief.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newchief.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Виконавцi</A>
			<UL class="submenu">
				<LI><A href="findperformer.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>

			<LI><A href="#">Документи</A>
				<UL class="submenu">
					<LI><A href="findchiefdoc.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newchiefdoc.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>

			<LI class="divider"><A href="#">Тарифи</A>
			<UL class="submenu">
				<LI><A href="findtarif.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newtarif.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Договора</A>
			<UL class="submenu">
				<LI><A href="printcontract.asp"><B>&#128424;</B>Друк</A></LI>
				<LI><A href="findcontract.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newcontract.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Споживачi</A>
			<UL class="submenu">
				<LI><A href="findcustomer.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newcustomer.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">Лiчильники</A>
			<UL class="submenu">
				<LI><A href="findmeter.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newmeter.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			
			<LI class="divider"><A href="#">ПДФО</A>
			<UL class="submenu">
				<LI><A href="findpdfo.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newpdfo.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI><A href="#">Вiйськовий збiр</A>
			<UL class="submenu">
				<LI><A href="findvz.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newvz.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
		</UL></LI>
	</UL>
</NAV>
