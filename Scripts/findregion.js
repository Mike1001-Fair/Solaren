FindRegion.addEventListener('input', () => {
	with (FindRegion) {
		SbmBtn.disabled = !RegionName.validity.valid;
	}
});

FindRegion.addEventListener('submit', () => {
	with (FindRegion) {
		RegionName.value = RegionName.value.trim();
	}
	Loader.Show();
});