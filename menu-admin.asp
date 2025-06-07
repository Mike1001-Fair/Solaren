<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.Authorize(0)) {
	Message.Write(2, Dictionary.Item("AuthorizationError"))
}%>
<NAV class="nav">
	<UL class="topmenu">
		<LI><A href="#" ID="LogOut">&#x23F9;<%=Dictionary.Item("Logout")%></A></LI>
		<LI><%=Dictionary.Item("Work")%>
		<UL class="submenu">
                        <LI><A href="editparameter.asp"><%=Dictionary.Item("Parameters")%></A></LI>
			<LI><A href="newreindexbase.asp"><%=Dictionary.Item("Reindexing")%></A></LI>
			<LI><A href="newshrinklog.asp"><%=Dictionary.Item("ShrinkLog")%></A></LI>
			<LI><A href="newbackupbase.asp"><%=Dictionary.Item("Backup")%></A></LI>
			<LI><A href="newupload.asp">Надіслати файл</A></LI>
			<LI><A href="newstatisticupdate.asp"><%=Dictionary.Item("Statistic")%></A></LI>
		</UL></LI>

		<LI><%=Dictionary.Item("Settings")%>
		<UL class="submenu">
			<LI><A href="#"><%=Dictionary.Item("Branches")%></A>
				<UL class="submenu">
					<LI><A href="findbranch.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newbranch.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Banks")%></A>
				<UL class="submenu">
					<LI><A href="findbank.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newbank.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI CLASS="divider"><A href="#"><%=Dictionary.Item("Streets")%></A>
				<UL class="submenu">
					<LI><A href="findstreet.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newstreet.asp"><%=Dictionary.Item("New2")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Localitys")%></A>
				<UL class="submenu">
					<LI><A href="findlocality.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newlocality.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Areas")%></A>
				<UL class="submenu">
					<LI><A href="findarea.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newarea.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Regions")%></A>
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

			<LI CLASS="divider"><A href="#"><%=Dictionary.Item("Positions")%></A>
				<UL class="submenu">
					<LI><A href="findchieftitle.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newchieftitle.asp"><%=Dictionary.Item("New2")%></A></LI>
				</UL>
			</LI>
			<LI><A href="serverinfo.asp"><%=Dictionary.Item("Server")%></A></LI>
			<LI><A href="#"><%=Dictionary.Item("Company")%></A>
				<UL class="submenu">
					<LI><A href="findcompany.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newcompany.asp"><%=Dictionary.Item("New2")%></A></LI>
				</UL>
			</LI>

			<LI><A href="#"><%=Dictionary.Item("Chiefs")%></A>
				<UL class="submenu">
					<LI><A href="findchief.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newchief.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI><A href="#"><%=Dictionary.Item("Documents")%></A>
				<UL class="submenu">
					<LI><A href="findchiefdoc.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newchiefdoc.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
			<LI CLASS="divider"><A href="#"><%=Dictionary.Item("Users")%></A>
				<UL class="submenu">
					<LI><A href="finduser.asp"><%=Dictionary.Item("Search")%></A></LI>
					<LI><A href="newuser.asp"><%=Dictionary.Item("New1")%></A></LI>
				</UL>
			</LI>
		</UL></LI>
	</UL>
</NAV>

