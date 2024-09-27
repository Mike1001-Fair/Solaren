FindChiefTitle.addEventListener('input', () => {
	with (FindChiefTitle) {
		SbmBtn.disabled = !TitleName.validity.valid;
	}
});

FindChiefTitle.addEventListener('submit', () => {
	with (FindChiefTitle) {
		TitleName.value = TitleName.value.trim();
	}
	Loader.Show();
});