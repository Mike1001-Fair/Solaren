<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% Resource.Load(User.ResourceFile());
var Title = Dictionary.Item("DefaultTitle");
with (Html) {
	SetHead(Title);
	WriteScript();
}%>
<BODY CLASS="StartBody">
<HEADER CLASS="HeaderDiv">
	<H3>&#127774;<%=Title%></H3>
</HEADER>

<MAIN>
	<FORM CLASS="FormDiv" NAME="Login" ID="Login" ACTION="login.asp" METHOD="post">
	<FIELDSET><LEGEND>&#128274;<%=Dictionary.Item("Authenticate")%></LEGEND>	
	<IMG SRC="Images/user.svg">
	<INPUT TYPE="text" NAME="LoginId" PLACEHOLDER="<%=Dictionary.Item("User")%>" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" SIZE="15" MAXLENGTH="10" AUTOFOCUS REQUIRED TITLE="<%=Dictionary.Item("UserTitle")%>">
	<INPUT TYPE="password" NAME="Pswd" PLACEHOLDER="<%=Dictionary.Item("Password")%>" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" SIZE="15" MAXLENGTH="10" REQUIRED TITLE="<%=Dictionary.Item("PasswordTitle")%>">
	</FIELDSET>
	<BUTTON TYPE="submit" CLASS="LoginBtn" NAME="SbmBtn">Ok</BUTTON>
	</FORM>
</MAIN>

<FOOTER CLASS="FooterDiv">
	<A HREF="mailto:Nickolay.Chernov@kresc.com.ua" TITLE="Лист автору для вiдгукiв, зауважень та пропозицiй"><%=Dictionary.Item("Author")%></A>
</FOOTER>
</BODY></HTML>