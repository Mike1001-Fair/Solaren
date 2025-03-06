<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Title = Dictionary.Item("Message");

if (!User.ValidateRole(User.RoleId, User.GUID)) {
	Message.Write(2, Dictionary.Item("AuthenticationError"))
}

Html.SetPage(Title, User.RoleId)%>
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

