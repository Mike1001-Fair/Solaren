<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<% with (Html) {
	SetHead("Файл експорту");
	WriteMenu(Session("RoleId"), 0);
}%>
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