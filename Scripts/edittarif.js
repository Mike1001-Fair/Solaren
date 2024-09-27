const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditTarif) {
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditTarif.addEventListener('input', () => {
	with (EditTarif) {
		EndDate.min     = BegDate.value;
   		ExpDateEnd.min  = ExpDateBeg.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid ||
				  !ExpDateBeg.validity.valid || !ExpDateEnd.validity.valid ||
				  !Tarif.validity.valid;
	}
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelTarif);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelTarif);
}

function DelTarif() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditTarif) {
			action = `deltarif.asp?TarifId=${TarifId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}