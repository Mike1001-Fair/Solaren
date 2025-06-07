<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Legend = Dictionary.Item("Message") || "Message",
Msg = Dictionary.Item("StopApp") || "Service temporarily unavailable";
Html.SetHead(Legend, 0)%>
<BODY CLASS="MsgBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND><%=Legend%></LEGEND>
		<FIGURE>
			<IMG SRC="Images/stop.svg" WIDTH="64" HEIGHT="64">
			<FIGCAPTION><%=Msg%></FIGCAPTION>
		</FIGURE>
	</FIELDSET>
</DIV></BODY></HTML>

