FindMeter.addEventListener('input', () => {
	with (FindMeter) {
		SbmBtn.disabled = (ContractId.value == -1 && MeterCode.value == "") || (MeterCode.value.length > 0 && !isDigit(MeterCode.value));
	}
});

FindMeter.addEventListener('submit', Loader.Show);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});