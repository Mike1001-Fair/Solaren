<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/msg.set" -->
<% Resource.Load(User.ResourceFile());
var ScriptName = Session("ScriptName") || "";
if (ScriptName.indexOf("login.asp") == -1) {
	if (!User.ValidateRole(User.RoleId)) {
		Message.Write(2, Dictionary.Item("AuthenticationError"))
	}
}
Html.SetHead(Dictionary.Item("Message"), 0)%>
<BODY CLASS="MainBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND><%=Dictionary.Item("Error")%></LEGEND>
		<H4><%=Dictionary.Item("WebAdminMessage")%></H4>
		<FIGURE>
			<IMG SRC="Images/tpattn.gif">
			<FIGCAPTION>
				<UL>
					<LI><%=ScriptName%></LI>
					<LI><%=Session("SysMsg")%></LI>
				</UL>
			</FIGCAPTION>
		</FIGURE>
	</FIELDSET>
</DIV></BODY></HTML>



