const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditStreet) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditStreet.addEventListener('input', () => {
	with (EditStreet) {
		SbmBtn.disabled = !StreetName.validity.valid;
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
	DelBtn.addEventListener('click', DelStreet);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelStreet);
}

function DelStreet() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditStreet) {
			action = `delstreet.asp?StreetId=${StreetId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}