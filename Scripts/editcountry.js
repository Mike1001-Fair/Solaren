const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditCountry) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditCountry.addEventListener('input', () => {
	with (EditCountry) {
		const valid = CountryName.validity.valid && TldCode.validity.valid
				&& IsoCode.validity.valid && ItuCode.validity.valid;
		SetDisabledButton(button, valid);
	}
})

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelCountry);
RestoreBtn?.addEventListener('click', DelCountry);

function DelCountry() {
	if (confirm(`Ви впевненi\u2753`)) {
		EditCountry.action = `delcountry.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}