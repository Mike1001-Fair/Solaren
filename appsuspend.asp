<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Msg = Dictionary.Item("Message");
Html.SetHead(Msg)%>
<BODY CLASS="MsgBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND><%=Msg%></LEGEND>
		<FIGURE>
			<IMG SRC="Images/suspend.svg" WIDTH="64" HEIGHT="64">
			<FIGCAPTION><%=Dictionary.Item("ServiceSuspended")%></FIGCAPTION>
		</FIGURE>
	</FIELDSET>
</DIV></BODY></HTML>
