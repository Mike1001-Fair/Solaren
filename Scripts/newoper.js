NewOper.addEventListener('input', () => {
	with (NewOper) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !VolCost.validity.valid
			|| !RetVol.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});