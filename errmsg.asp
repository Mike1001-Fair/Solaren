<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (User.ValidateRole(User.RoleId)) {
	Html.SetPage(Dictionary.Item("Message"))
} else {
	Message.Write(2, Dictionary.Item("AuthenticationError"))
}%>
<BODY CLASS="MainBody">
<DIV CLASS="SysMsg">
	<FIELDSET>		
		<LEGEND><%=Html.Title%></LEGEND>
		<H4><%=Session("SysMsg")%></H4>
		<A HREF="javascript:window.history.go(-1)" ID="BackLink">
		<FIGURE>
			<IMG NAME="ErrImg" ID="ErrImg" SRC="Images/tpattn.gif" WIDTH="74" HEIGHT="66">
			<FIGCAPTION><%=Dictionary.Item("Attention")%></FIGCAPTION>
		</FIGURE></A>
	</FIELDSET>
</DIV></BODY></HTML>



