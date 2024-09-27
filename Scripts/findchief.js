FindChief.addEventListener('input', () => {
	with (FindChief) {
		SbmBtn.disabled = !ChiefName.validity.valid;
	}
});

FindChief.addEventListener('submit', () => {
	with (FindChief) {
		ChiefName.value = ChiefName.value.trim();
	}
	Loader.Show();
});