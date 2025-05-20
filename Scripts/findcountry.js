FindCountry.addEventListener('input', () => {
	with (FindCountry) {
		SbmBtn.disabled = !CountryName.validity.valid || CountryId.value == -1;
	}
});

FindCountry.addEventListener('submit', () => {
	Loader.Show();
});

CountryName.addEventListener('input', function() {
	Ajax.GetCountryList(this);
});