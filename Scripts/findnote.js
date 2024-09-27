FindNote.addEventListener('input', () => {
	with (FindNote) {
		SbmBtn.disabled = !ReportMonth.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});