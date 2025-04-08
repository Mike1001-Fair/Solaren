FindContractCount.addEventListener('input', () => {
	with (FindContractCount) {
		SbmBtn.disabled = !ReportDate.validity.valid;
	}
});