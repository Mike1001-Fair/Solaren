<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/msg.set" -->
<% Resource.Load(User.ResourceFile());
if (!User.ValidateRole(User.RoleId)) {
	Message.Write(2, Dictionary.Item("AuthenticationError"))
}
Html.SetPage("Файл")%>
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


