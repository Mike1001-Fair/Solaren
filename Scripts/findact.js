FindAct.addEventListener('input', () => {
	with (FindAct) {
		action = AllContract.checked ? "prnallact.asp" : "prnact.asp";
		if (AllContract.checked) ContractName.value = '';
		ContractName.disabled = AllContract.checked;
		SbmBtn.disabled = !ReportMonth.validity.valid || (ContractId.value == -1 && !AllContract.checked);
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});