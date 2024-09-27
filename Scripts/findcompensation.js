FindCompensation.addEventListener('input', () => {
	with (FindCompensation) {
		SbmBtn.disabled = !ReportMonth.validity.valid || !AveragePrice.validity.valid;
	}
});
