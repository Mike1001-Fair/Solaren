FindUser.addEventListener('input', () => {
	with (FindUser) {
		SbmBtn.disabled = !LoginId.validity.valid;
	}
});

FindUser.addEventListener('submit', () => {
	const Elements = document.querySelectorAll("input[type='text']");
	Elements.forEach(elm => elm.value = elm.value.trim());
	Loader.Show();
});
