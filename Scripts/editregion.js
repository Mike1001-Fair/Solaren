const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditRegion) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditRegion.addEventListener('input', () => {
	with (EditRegion) {
		SbmBtn.disabled = !SortCode.validity.valid || !RegionName.validity.valid;
	}
})

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		confirm(`Ви впевненi❓`) ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelRegion);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelRegion);
}

function DelRegion() {
	if (confirm(`Ви впевненi❓`)) {
		with (EditRegion) {
			action = `delregion.asp?RegionId=${RegionId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}