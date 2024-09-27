NewChief.addEventListener('input', () => {
	with (NewChief) {
		SbmBtn.disabled = !Name1.validity.valid || !Name2.validity.valid || !Name3.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm(`Ви впевненi❓`)) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});