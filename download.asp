<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
if (!User.ValidateRole(User.RoleId, User.GUID)) {
	Message.Write(2, Dictionary.Item("AuthenticationError"))
}
Html.SetPage("Файл", User.RoleId)%>
<BODY CLASS="MainBody">
<DIV CLASS="SysMsg">
	<FIELDSET>		
		<LEGEND>Файл</LEGEND>
		<A HREF="<%=Session("FileName")%>">
		<FIGURE>
			<IMG SRC="Images/download.svg" WIDTH="64" HEIGHT="64">
			<FIGCAPTION>Завантажити</FIGCAPTION>
		</FIGURE></A>
	</FIELDSET>
</DIV></BODY></HTML>