<%@ LANGUAGE = "JScript"%> 
<!-- #INCLUDE FILE="Include/solaren.inc" -->
<!-- #INCLUDE FILE="Include/message.inc" -->
<!-- #INCLUDE FILE="Include/html.inc" -->
<!-- #INCLUDE FILE="Include/menu.inc" -->
<!-- #INCLUDE FILE="Include/user.inc" -->
<!-- #INCLUDE FILE="Include/resource.inc" -->
<% var Authorized = User.RoleId >= 0 && User.RoleId < 2,
BranchId = Request.QueryString("BranchId");

User.CheckAccess(Authorized, "GET");

try {
	Solaren.SetCmd("SelectChiefBranch");
	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("UserId", adVarChar, adParamInput, 10, User.Id));
		}
	}	
	var rsChief = Solaren.Execute("SelectChiefBranch", "Довiдник керівників пустий!"),
	rsCompany = Solaren.Execute("SelectCompany", "Довiдник підприємств пустий!");

	with (Cmd) {
		with (Parameters) {
			Append(CreateParameter("BranchId", adInteger, adParamInput, 10, BranchId));
		}
	}

	var rsBranch = Solaren.Execute("GetBranch", "Інформацію не знадено!");
} catch (ex) {
	Message.Write(3, Message.Error(ex))
} finally {
	var Branch = Solaren.Map(rsBranch.Fields);
	rsBranch.Close();
	Html.SetPage(Branch.Deleted ? "Перегляд анкети ЦОС" : "Редагування анкети ЦОС");
}%>
<BODY CLASS="MainBody">
<FORM CLASS="ValidForm" NAME="EditBranch" ACTION="updatebranch.asp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="BranchId" VALUE="<%=BranchId%>">
<INPUT TYPE="HIDDEN" NAME="AreaId" ID="AreaId" VALUE="<%=Branch.AreaId%>">
<INPUT TYPE="HIDDEN" NAME="LocalityId" ID="LocalityId" VALUE="<%=Branch.LocalityId%>">
<INPUT TYPE="HIDDEN" NAME="Deleted" VALUE="<%=Branch.Deleted%>">
<H3 CLASS="HeadText" ID="H3Id">&#127980;<%=Html.Title%></H3>
<TABLE CLASS="MarkupTable">
	<TR><TD ALIGN="CENTER">
	<FIELDSET><LEGEND>Параметри</LEGEND>
	<TABLE><TR><TD ALIGN="RIGHT">№</TD>
	<TD><INPUT TYPE="Number" NAME="SortCode" VALUE="<%=Branch.SortCode%>" MIN="1" MAX="99" REQUIRED></TD></TR>
	<TR><TD ALIGN="RIGHT">Назва</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName1" PLACEHOLDER="Коротка без лапок" VALUE="<%=Branch.BranchName1%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Чого?</TD>
	<TD><INPUT TYPE="TEXT" NAME="BranchName2" PLACEHOLDER="Коротка без лапок" VALUE="<%=Branch.BranchName2%>" SIZE="30" MAXLENGTH="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Район</TD>
	<TD><% Html.WriteInputDataList("Area", Branch.AreaName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT" ID="LocalityType">Пункт</TD>
	<TD><% Html.WriteInputDataList("Locality", Branch.LocalityName, 30) %></TD></TR>

	<TR><TD ALIGN="RIGHT">Керiвник</TD>
	<TD><% Html.WriteSelect(rsChief, "Chief", 0, Branch.ChiefId)%></TD></TR>

	<TR><TD ALIGN="RIGHT">Бухгалтер</TD>
	<TD><INPUT TYPE="TEXT" NAME="Accountant" PLACEHOLDER="ПІБ" VALUE="<%=Branch.Accountant%>" SIZE="30" maxLength="30" REQUIRED></TD></TR>

	<TR><TD ALIGN="RIGHT">Компанія</TD>
	<TD><% Html.WriteSelect(rsCompany, "Company", 0, Branch.CompanyId)%></TD></TR>

	</TABLE></FIELDSET></TD></TR>
</TABLE>
<% Html.WriteEditButton(1, Branch.Deleted);
Solaren.Close() %>
</FORM></BODY></HTML>


