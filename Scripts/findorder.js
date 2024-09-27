FindOrder.addEventListener('input', () => {
	with (FindOrder) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || ContractId.value == -1;
	}
});

FindOrder.addEventListener('submit', Loader.Show);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});