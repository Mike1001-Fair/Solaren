NewCountry.addEventListener('input', () => {
	with (NewCountry) {
		SbmBtn.disabled = !CountryName.validity.valid || !TldCode.validity.valid || !IsoCode.validity.valid || !ItuCode.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});