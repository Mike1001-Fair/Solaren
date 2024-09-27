NewRegion.addEventListener('input', () => {
	with (NewRegion) {
		SbmBtn.disabled = !SortCode.validity.valid || !RegionName.validity.valid;
	}
})

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else event.preventDefault();
});