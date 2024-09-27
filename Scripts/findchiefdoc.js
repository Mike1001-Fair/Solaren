FindChiefDoc.addEventListener('input', () => {
	with (FindChiefDoc) {
		SbmBtn.disabled = !DocName.validity.valid;
	}
});

FindChiefDoc.addEventListener('submit', () => {
	with (FindChiefDoc) {
		DocName.value = DocName.value.trim();
	}
	Loader.Show();
});