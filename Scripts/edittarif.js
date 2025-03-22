const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	if (EditTarif.Deleted.value == "True" || EditTarif.ViewOnly.value == "True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	} else {
		ChkForm()
	}
});

EditTarif.addEventListener('input', ChkForm);

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelTarif);
RestoreBtn?.addEventListener('click', DelTarif);

function ChkForm() {
	with (EditTarif) {
		const valid = BegDate.validity.valid && EndDate.validity.valid &&
			ExpDateBeg.validity.valid && ExpDateEnd.validity.valid && Tarif.validity.valid;
		EndDate.min     = BegDate.value;
   		ExpDateEnd.min  = ExpDateBeg.value;
		SetDisabledButton(button, valid);
	}
}

function DelTarif() {
	if (confirm("Ви впевненi\u2753")) {
		EditTarif.action = `deltarif.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}