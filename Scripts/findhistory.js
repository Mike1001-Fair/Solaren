FindHistory.addEventListener('input', () => {
	with (FindHistory) {
		BegMonth.max = EndMonth.value;
		SbmBtn.disabled = !BegMonth.validity.valid || !EndMonth.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});