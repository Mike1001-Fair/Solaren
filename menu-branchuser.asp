<%@ LANGUAGE="JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.Authorize(2)) {
	Message.Write(2, Dictionary.Item("AuthorizationError"))
}%>
<INPUT TYPE="HIDDEN" NAME="MsgText" ID="MsgText" VALUE="<%=Session('MsgText')%>">
<NAV class="nav">
	<UL class="topmenu">
		<LI><A href="#" ID="LogOut">&#x23F9;<%=Dictionary.Item("Logout")%></A></LI>
		<LI><%=Dictionary.Item("Indicator")%>
			<UL class="submenu">
				<LI><A href="findindicator.asp"><%=Dictionary.Item("Search")%></A></LI>
				<%if (Session("NewIndicator")) {
					Response.Write('<LI><A href="newindicator.asp">' + Dictionary.Item("New3") + '</A></LI>');
				}%>
			</UL>
		</LI>
		<LI><%=Dictionary.Item("Reports")%>
			<UL class="submenu">
				<LI><A href="findact.asp">Акт</A></LI>
				<LI><A href="findvolcost.asp">Вартicть</A></LI>
				<LI><A href="findindicatorrep.asp">Показники</A></LI>
				<LI><A href="listnovol.asp">Без обсягiв</A></LI>
			</UL>
		</LI>
	</UL>
</NAV>
