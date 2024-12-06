<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/lib.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId == 1,
OperMonth = Html.GetMonth(1),
Title = "Iмпорт";
if (User.ValidateAccess(Authorized, "GET")) {
	Html.SetPage(Title, User.RoleId)
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="NewImport" ACTION="loadindicator.asp" METHOD="post">

<H3 CLASS="HeadText"><IMG SRC="Images/importdb.png" NAME="ImportImg" ID="ImportImg" WIDTH="32" HEIGHT="32">Iмпорт</H3>
<TABLE CLASS="MarkupTable">
	<TR><TD>
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE>
	<TR><TD ALIGN="RIGHT">Перioд</TD>
	<TD><INPUT TYPE="Month" NAME="OperMonth" VALUE="<%=OperMonth%>" MAX="<%=OperMonth%>" READONLY></TD></TR>

	<TR><TD ALIGN="RIGHT">Тип</TD>
	<TD><SELECT NAME="FileType" ID="FileType">
	<OPTION VALUE="0">Показників</OPTION>
	<OPTION VALUE="1">Оплат</OPTION></SELECT></TD></TR>

	<TR><TD ALIGN="RIGHT">Файл</TD>
	<TD><INPUT TYPE="TEXT" NAME="SourceFile" VALUE="Import\indicatorimport.txt" SIZE="30" READONLY></TD></TR>


	<!--TR><TD ALIGN="RIGHT">Файл</TD>
	<TD><% //Html.WriteFileList("Import/")%></TD></TR-->

	<!--TR><TD ALIGN="RIGHT">Файл</TD>
	<TD><INPUT TYPE="search" NAME="DataFile" ID="DataFile" SIZE="30" LIST="FileList" REQUIRED>
	<DATALIST ID="FileList" data-foldername="Import/"></DATALIST></TD></TR-->

	</TABLE></FIELDSET></TD></TR>
</TABLE>

<BUTTON TYPE="button" CLASS="SbmBtn" NAME="TestBtn" ID="TestBtn">&#128736;Тест</BUTTON>
<BUTTON TYPE="button" CLASS="SbmBtn" NAME="SbmBtn" ID="SbmBtn">&#11015;Завантажити</BUTTON></FORM></BODY></HTML>