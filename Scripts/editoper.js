const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditOper) {
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditOper.addEventListener('input', () => {
	with (EditOper) {
		if (SbmBtn) {
			SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid ||
				!VolCost.validity.valid || !RetVol.validity.valid;
		}
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else event.preventDefault();
});

DelBtn?.addEventListener('click', DelFactVol);
RestoreBtn?.addEventListener('click', DelFactVol);

function DelFactVol() {
	if (confirm("Ви впевненнi ?")) {
		with (EditOper) {
			action = `delfactvol.asp?PayId=${FactVolId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}