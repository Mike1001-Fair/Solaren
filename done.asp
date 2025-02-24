<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.ValidateRole(User.RoleId, User.GUID)) {
	Solaren.SysMsg(2, Dictionary.Item("AuthenticationError"))
}
Html.SetPage(Dictionary.Item("Message"), User.RoleId)%>
<BODY CLASS="MainBody">
<DIV CLASS="SysMsg">
	<FIELDSET>		
		<LEGEND><%=Html.Title%></LEGEND>
		<H4><%=Session("SysMsg")%></H4>
		<A HREF="javascript:window.history.go(-1)" ID="BackLink">
		<FIGURE>
			<IMG NAME="DoneImg" ID="DoneImg" SRC="Images/done.svg" WIDTH="64" HEIGHT="64">
			<FIGCAPTION><%=Dictionary.Item("Done")%></FIGCAPTION>
		</FIGURE></A>
	</FIELDSET>
</DIV></BODY></HTML>