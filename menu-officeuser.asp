<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.Authorize(1)) {
	Message.Write(2, Dictionary.Item("AuthorizationError"))
}%>
<INPUT TYPE="HIDDEN" NAME="MsgText" ID="MsgText" VALUE="<%=Session('MsgText')%>">
<NAV class="nav">
	<UL class="topmenu">
		<LI><A href="#" ID="LogOut">&#x23F9;<%=Dictionary.Item("Logout")%></A></LI>
		<LI><%=Dictionary.Item("Work")%>
		<UL class="submenu">
			<LI><A href="#">�����</A>
			<UL class="submenu">
				<LI><A href="findvol.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newfactvol.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="newimport.asp">I�����</A></LI>
			<LI><A href="#">������</A>
			<UL class="submenu">
				<LI><A href="findpay.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newpay.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI><A href="findapplog.asp">������</A></LI>

			<LI><A href="#">����������</A>
			<UL class="submenu">
				<LI><A href="findorder.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="neworder.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

                        <LI class="divider"><A href="newexport.asp">�������</A></LI>

			<LI><A href="#">���������</A>
			<UL class="submenu">
				<LI><A href="findindicator.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>
                        <LI><A href="editparameter.asp">���������</A></LI>
			<LI><A href="#">�����������</A>
			<UL class="submenu">
				<LI><A href="findoper.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newoper.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI class="divider"><A href="newconsolidation.asp">������i���i�</A></LI>
			<LI><A href="listnopurvol.asp">�����i��� �����i�</A></LI>
			<LI><A href="listnotarif.asp">�����i��� ������</A></LI>
			<LI><A href="listnovol.asp">�������� ��� �����i�</A></LI>
			<LI class="divider"><A href="newmonth.asp">�������� �ic���</A></LI>
		</UL></LI>
		<LI><%=Dictionary.Item("Reports")%>
		<UL class="submenu">
			<LI><A href="findregistry.asp">�����</A></LI>
			<LI><A href="findfactvol.asp">������</A></LI>
			<LI><A href="findbalance.asp">������</A></LI>
			<LI><A href="findsov.asp">���������</A></LI>
			
			<LI class="divider"><A href="findcompensation.asp">�����������</A></LI>
			<LI><A href="findbudgetcode.asp">��������� ���</A></LI>
			<LI><A href="findoperatoract.asp">��� ����� ���</A></LI>
			<LI><A href="findbranchact.asp">�������� ����</A></LI>

			<LI class="divider"><A href="findnote.asp">��������� ����</A></LI>
			<LI><A href="findvolrem.asp">����ic�� �� ���</A></LI>
			<LI><A href="findvolpay.asp">����������������</A></LI>
			<LI><A href="findcontractnumber.asp">�i���i��� �������i�</A></LI>

			<LI class="divider"><A href="findhistory.asp">I����i� ���������i�</A></LI>
			<LI><A href="findtarifvol.asp">������ �� �������</A></LI>
			<LI><A href="findvolcost.asp">����ic�� �� ���������</A></LI>
			<LI><A href="findsalesreport.asp">��� �� ��������</A></LI>
		</UL></LI>
		<LI><%=Dictionary.Item("Directories")%>
		<UL class="submenu">
			<LI><A href="#"><%=Dictionary.Item("Branches")%></A>
			<UL class="submenu">
				<LI><A href="findbranch.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>
			<LI><A href="#">���</A>
			<UL class="submenu">
				<LI><A href="findaen.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newaen.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
                        <LI><A href="#">�����</A>
			<UL class="submenu">
				<LI><A href="findbank.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newbank.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">���������</A>
			<UL class="submenu">
				<LI><A href="findoperator.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newoperator.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>

			<LI class="divider"><A href="#">������</A>
			<UL class="submenu">
				<LI><A href="findstreet.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newstreet.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
			<LI><A href="#">������</A>
			<UL class="submenu">
				<LI><A href="findlocality.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newlocality.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">������</A>
				<UL class="submenu">
					<LI><A href="findarea.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newarea.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#">������</A>
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

			<LI class="divider"><A href="#">������</A>
			<UL class="submenu">
				<LI><A href="findchieftitle.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newchieftitle.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
			<LI><A href="findcompany.asp">�������</A>
			<LI><A href="#">���i�����</A>
			<UL class="submenu">
				<LI><A href="findchief.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newchief.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">��������i</A>
			<UL class="submenu">
				<LI><A href="findperformer.asp"><%=Dictionary.Item("Search")%></A></LI>
			</UL></LI>

			<LI><A href="#">���������</A>
				<UL class="submenu">
					<LI><A href="findchiefdoc.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newchiefdoc.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>

			<LI class="divider"><A href="#">������</A>
			<UL class="submenu">
				<LI><A href="findtarif.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newtarif.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">��������</A>
			<UL class="submenu">
				<LI><A href="printcontract.asp"><B>&#128424;</B>����</A></LI>
				<LI><A href="findcontract.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newcontract.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">��������i</A>
			<UL class="submenu">
				<LI><A href="findcustomer.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newcustomer.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			<LI><A href="#">�i��������</A>
			<UL class="submenu">
				<LI><A href="findmeter.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newmeter.asp"><%=Dictionary.Item("New1")%></A></LI>
			</UL></LI>
			
			<LI class="divider"><A href="#">����</A>
			<UL class="submenu">
				<LI><A href="findpdfo.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newpdfo.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>

			<LI><A href="#">�i�������� ��i�</A>
			<UL class="submenu">
				<LI><A href="findvz.asp"><%=Dictionary.Item("Search")%></A></LI>
				<LI><A href="newvz.asp"><%=Dictionary.Item("New2")%></A></LI>
			</UL></LI>
		</UL></LI>
	</UL>
</NAV>

