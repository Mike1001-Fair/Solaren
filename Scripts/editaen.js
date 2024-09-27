const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditAen) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditAen.addEventListener('input', () => {
	with (EditAen) {
		SbmBtn.disabled = !SortCode.validity.valid || !AenName.validity.valid;
	}
})

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			Loader.Show();
		} else event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelAen);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelAen);
}

function DelAen() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditAen) {
			action = `delaen.asp?AenId=${AenId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}