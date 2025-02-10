const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	if (EditMeter.Deleted.value=="True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	}
});

EditMeter.addEventListener('input', () => {
	with (EditMeter) {
		const limit = Math.pow(10, Capacity.value) - 1;
		RecVal.max = limit;
		RetVal.max = limit;
		SbmBtn.disabled = !MeterCode.validity.valid || !SetDate.validity.valid || !RecVal.validity.valid ||
			!RetVal.validity.valid || ContractId.value == -1;
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelMeter);
RestoreBtn?.addEventListener('click', DelMeter);

function DelMeter() {
	if (confirm("Ви впевненi\u2753")) {
		EditMeter.action = `delmeter.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}