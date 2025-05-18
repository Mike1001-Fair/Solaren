<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var phUser = Dictionary.Item("User"),
phPswd     = Dictionary.Item("Password"),
titleUser  = Dictionary.Item("UserTitle"),
titlePswd  = Dictionary.Item("PasswordTitle");

Html.SetHead(Dictionary.Item("DefaultTitle"), 1);
Html.WriteScript()%>
<BODY CLASS="StartBody">
<HEADER CLASS="HeaderDiv">
	<H3>&#127774;<%=Html.Title%></H3>
</HEADER>
<MAIN>
	<FORM CLASS="FormDiv" NAME="Login" ID="Login" ACTION="login.asp" METHOD="post">
	<FIELDSET><LEGEND>&#128274;<%=Dictionary.Item("Authenticate")%></LEGEND>	
	<IMG SRC="Images/user.svg">
	<INPUT TYPE="text" NAME="LoginId" PLACEHOLDER="<%=phUser%>" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" SIZE="15" MAXLENGTH="10" AUTOFOCUS REQUIRED TITLE="<%=titleUser%>">
	<INPUT TYPE="password" NAME="Pswd" PLACEHOLDER="<%=phPswd%>" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" SIZE="15" MAXLENGTH="10" REQUIRED TITLE="<%=titlePswd%>">
	</FIELDSET>
	<BUTTON TYPE="submit" CLASS="LoginBtn" NAME="SbmBtn">Ok</BUTTON>
	</FORM>
</MAIN>
<FOOTER CLASS="FooterDiv">
	<A HREF="mailto:nickchernov@gmail.com" TITLE="<%=Dictionary.Item("FeedbackSheet")%>"><%=Dictionary.Item("Author")%></A>
</FOOTER>
</BODY></HTML>

