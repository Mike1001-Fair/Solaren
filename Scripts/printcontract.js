PrintContract.addEventListener('input', () => {
	with (PrintContract) {
		SbmBtn.disabled = ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});