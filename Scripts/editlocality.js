const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditLocality) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditLocality.addEventListener('input', () => {
	with (EditLocality) {
		SbmBtn.disabled = !LocalityName.validity.valid;
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
	DelBtn.addEventListener('click', DelLocality);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelLocality);
}

function DelLocality() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditLocality) {
			action = `dellocality.asp?LocalityId=${LocalityId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}