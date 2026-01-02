<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/msg.set" -->
<% Resource.Load(User.ResourceFile());
var AccessDenied = Dictionary.Item("AccessDenied"),
Msg = Session("SysMsg") || Dictionary.Item("AuthenticationError");
Html.SetHead(AccessDenied)%>
<BODY CLASS="MsgBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND><%=Dictionary.Item("Message")%></LEGEND>
		<H4><%=Msg%></H4>
		<A HREF="default.asp">
			<FIGURE>
				<IMG SRC="images/key.gif" WIDTH="106" HEIGHT="51">
				<FIGCAPTION><%=AccessDenied%></FIGCAPTION>
			</FIGURE>
		</A>
	</FIELDSET>
</DIV></BODY></HTML>

