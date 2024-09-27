FindLocality.addEventListener('input', () => {
	with (FindLocality) {
		SbmBtn.disabled = !LocalityName.validity.valid || LocalityId.value == -1;
	}
});

FindLocality.addEventListener('submit', () => {
	FindLocality.action = `editlocality.asp?LocalityId=${LocalityId.value}`;
	Loader.Show();
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this);
});