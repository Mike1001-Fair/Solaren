const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditArea) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditArea.addEventListener('input', () => {
	with (EditArea) {
		SbmBtn.disabled = !SortCode.validity.valid || !AreaName.validity.valid;
	}
})

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelArea);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelArea);
}

function DelArea() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditArea) {
			action = `delarea.asp?AreaId=${AreaId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}