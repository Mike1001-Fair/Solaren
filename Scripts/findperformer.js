FindPerformer.addEventListener('input', () => {
	with (FindPerformer) {
		SbmBtn.disabled = !PerformerName.validity.valid;
	}
});

FindPerformer.addEventListener('submit', () => {
	with (FindPerformer) {
		PerformerName.value = PerformerName.value.trim();
	}
	Loader.Show();
});