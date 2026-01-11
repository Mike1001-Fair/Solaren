<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE VIRTUAL="Solaren/Set/default.set" -->
<% Resource.Load(User.ResourceFile());
var titlePage =  Dictionary.Item("DefaultTitle"),
phUserName = Dictionary.Item("UserName"),
phPswd = Dictionary.Item("Password"),
titleUser = Dictionary.Item("UserTitle"),
titlePswd = Dictionary.Item("PasswordTitle");
Html.SetHead(titlePage, 1);
Html.WriteScript()%>
<BODY CLASS="StartBody">
<HEADER CLASS="HeaderDiv">
	<H3>&#127774;<%=Html.Title%></H3>
</HEADER>
<MAIN>
	<FORM CLASS="FormDiv" NAME="Login" ID="Login" ACTION="login.asp" METHOD="post">
	<FIELDSET><LEGEND>&#128274;<%=Dictionary.Item("Authenticate")%></LEGEND>	
	<IMG SRC="Images/user.svg">
	<INPUT TYPE="text" NAME="UserName" PLACEHOLDER="<%=phUserName%>" PATTERN="(?=.*[a-z])(?=.*[A-Z]).{8,10}" SIZE="15" MAXLENGTH="10" AUTOFOCUS REQUIRED TITLE="<%=titleUser%>">
	<INPUT TYPE="password" NAME="Pswd" PLACEHOLDER="<%=phPswd%>" PATTERN="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10}" SIZE="15" MAXLENGTH="10" REQUIRED TITLE="<%=titlePswd%>">
	</FIELDSET>
	<BUTTON TYPE="submit" CLASS="LoginBtn" NAME="SbmBtn">Ok</BUTTON>
	</FORM>
</MAIN>
<FOOTER CLASS="FooterDiv">
	<A HREF="mailto:nickchernov@gmail.com" TITLE="<%=Dictionary.Item("FeedbackSheet")%>"><%=Dictionary.Item("Author")%></A>
</FOOTER>
</BODY></HTML>


