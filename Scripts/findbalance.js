FindBalance.addEventListener('input', () => {
	with (FindBalance) {
		BegMonth.max = EndMonth.value;
		SbmBtn.disabled = !BegMonth.validity.valid || !EndMonth.validity.valid;
	}
});

FindBalance.addEventListener('submit', () => {
	with (FindBalance) {
		const selectedOption = OperatorId.options[OperatorId.selectedIndex];
		OperatorName.value = selectedOption.text;		
	}
});
