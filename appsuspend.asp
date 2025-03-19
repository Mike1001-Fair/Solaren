<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Msg = Dictionary.Item("Message") || "Message",
ServiceMsg = Dictionary.Item("ServiceSuspended") || "Service temporarily unavailable";
Html.SetHead(Msg, 0)%>
<BODY CLASS="MsgBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND><%=Msg%></LEGEND>
		<FIGURE>
			<IMG SRC="Images/suspend.svg" WIDTH="64" HEIGHT="64">
			<FIGCAPTION><%=ServiceMsg%></FIGCAPTION>
		</FIGURE>
	</FIELDSET>
</DIV></BODY></HTML>
