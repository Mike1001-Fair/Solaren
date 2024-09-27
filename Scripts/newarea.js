NewArea.addEventListener('input', () => {
	with (NewArea) {
		SbmBtn.disabled = !SortCode.validity.valid || !AreaName.validity.valid;
	}
})

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else event.preventDefault();
});