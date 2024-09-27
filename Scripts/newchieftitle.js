NewChiefTitle.addEventListener('input', () => {
	with (NewChiefTitle) {
		SbmBtn.disabled = !Title1.validity.valid || !Title2.validity.valid || !Title3.validity.valid || !RankId.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm(`Ви впевненi❓`)) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});