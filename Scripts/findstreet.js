FindStreet.addEventListener('input', () => {
	with (FindStreet) {
		SbmBtn.disabled = !StreetName.validity.valid || StreetId.value == -1;
	}
});

FindStreet.addEventListener('submit', () => {
	FindStreet.action = `editstreet.asp?StreetId=${StreetId.value}`;
	Loader.Show();
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this);
});