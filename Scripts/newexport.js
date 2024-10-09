NewExport.addEventListener('submit', () => {
	with (NewExport) {
		const Scripts  = ["create1cagent", "create1caccrual", "create1ctopay"],
		selectedOption = ReportCodePage.options[ReportCodePage.selectedIndex];
		ReportCharSet.value = selectedOption.text;
		action = Scripts[FileType.value] + ".asp";
	}
	if (NewExport.FileType.value == 2) Loader.Show();
});