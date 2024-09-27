NewMeter.addEventListener('input', () => {
	with (NewMeter) {
		const limit = Math.pow(10, Capacity.value) - 1;
		RecVal.max = limit;
		RetVal.max = limit;
		SbmBtn.disabled = !MeterCode.validity.valid || !SetDate.validity.valid || !RecVal.validity.valid || !RetVal.validity.valid || ContractId.value == -1;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});


ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});