const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

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
		SbmBtn.disabled = !CountryName.validity.valid || !TldCode.validity.valid || !IsoCode.validity.valid || !ItuCode.validity.valid;
	}
})

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
	DelBtn.addEventListener('click', DelCountry);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelCountry);
}

function DelCountry() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditCountry) {
			action = `delcountry.asp?CountryId=${CountryId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}