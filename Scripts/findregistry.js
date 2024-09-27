FindRegistry.addEventListener('input', () => {
	with (FindRegistry) {
		SbmBtn.disabled = !ReportMonth.validity.valid || !CustomerCount.validity.valid;
	}
});