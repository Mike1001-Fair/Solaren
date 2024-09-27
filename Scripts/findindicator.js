FindIndicator.addEventListener('input', () => {
	with (FindIndicator) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

FindIndicator.addEventListener('submit', Loader.Show);