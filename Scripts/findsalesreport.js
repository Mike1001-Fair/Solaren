FindSalesReport.addEventListener('input', () => {
	with (FindSalesReport) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid;
	}
});

FindSalesReport.addEventListener('submit', Loader.Show);