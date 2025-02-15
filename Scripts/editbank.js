const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditBank) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm();
		}
	}
});

EditBank.addEventListener('input', ChkForm);

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelBank);
RestoreBtn?.addEventListener('click', DelBank);

function DelBank() {
	if (confirm(`Ви впевненi\u2753`)) {
		EditBank.action = `delbank.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}

function ChkForm() {
	with (EditBank) {
		const isValidMfo = isMfoCode(MfoCode.value),
		isValidEdrpo = isEdrpoCode(EdrpoCode.value),
		valid = isValidMfo && isValidEdrpo && BankName.validity.valid;
		MfoCode.style.color = isValidMfo ? "#000000" : "#FF0000";
		EdrpoCode.style.color = isValidEdrpo ? "#000000" : "#FF0000";
		[SbmBtn, DelBtn].forEach(btn => btn && (btn.disabled = !valid));
	}
}