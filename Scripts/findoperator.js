FindOperator.addEventListener('input', () => {
	with (FindOperator) {
		SbmBtn.disabled = !OperatorName.validity.valid;
	}
});

FindOperator.addEventListener('submit', () => {
	with (FindOperator) {
		OperatorName.value = OperatorName.value.trim();
	}
	Loader.Show();
});