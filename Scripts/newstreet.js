NewStreet.addEventListener('input', () => {
	with (NewStreet) {
		SbmBtn.disabled = !StreetName.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
});