NewLocality.addEventListener('input', () => {
	with (NewLocality) {
		SbmBtn.disabled = !LocalityName.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else event.preventDefault();
});