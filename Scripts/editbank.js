const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditBank) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
			H3Id.textContent = H3Id.textContent.replace("Редагування", "Перегляд");
		}
	}
});

EditBank.addEventListener('input', () => {
	with (EditBank) {
		MfoCode.style.color = isMfoCode(MfoCode.value) ? "#000000" : "#FF0000";
		EdrpoCode.style.color = isEdrpoCode(EdrpoCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = EdrpoCode.style.color == "rgb(255, 0, 0)" || MfoCode.style.color == "rgb(255, 0, 0)" || !BankName.validity.valid;
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
	DelBtn.addEventListener('click', DelBank);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelBank);
}

function DelBank() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditBank) {
			action = `delbank.asp?BankId=${BankId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}