FindContractNumber.addEventListener('input', () => {
	with (FindContractNumber) {
		SbmBtn.disabled = !ReportDate.validity.valid;
	}
});