const SbmBtn = document.getElementById('SbmBtn');

EditPerformer.addEventListener('input', () => {
	with (EditPerformer) {
		SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || !MiddleName.validity.valid || !Phone.validity.valid;
	}
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else event.preventDefault();
	});
}