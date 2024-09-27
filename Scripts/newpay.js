NewPay.addEventListener('input', () => {
	with (NewPay) {
		SbmBtn.disabled = !PayDate.validity.valid || !PaySum.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});