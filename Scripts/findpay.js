FindPay.addEventListener('input', () => {
	with (FindPay) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || ContractId.value == -1;
	}
});

FindPay.addEventListener('submit', Loader.Show);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});