<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<% Html.SetHead("Message", 0) %>
<BODY CLASS="MainBody">
<DIV CLASS="SysMsg">
	<FIELDSET>
		<LEGEND>Error</LEGEND>
		<H4>Contact the web server administrator!</H4>
		<FIGURE>
			<IMG SRC="Images/tpattn.gif">
			<FIGCAPTION>
				<UL>
					<LI><%=Session("ScriptName")%></LI>
					<LI><%=Session("SysMsg")%></LI>
				</UL>
			</FIGCAPTION>
		</FIGURE>
	</FIELDSET>
</DIV></BODY></HTML>

