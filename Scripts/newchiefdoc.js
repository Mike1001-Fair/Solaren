NewChiefDoc.addEventListener('input', () => {
	with (NewChiefDoc) {
		SbmBtn.disabled = !DocName.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm(`Ви впевненi❓`)) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});