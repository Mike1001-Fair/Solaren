const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditChief) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditChief.addEventListener('input', () => {
	with (EditChief) {
		SbmBtn.disabled = !Name1.validity.valid || !Name2.validity.valid || !Name3.validity.valid;
	}

})

SbmBtn?.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			Loader.Show();
		} else {
			event.preventDefault();
		}
});

DelBtn?.addEventListener('click', DelChief);
RestoreBtn?.addEventListener('click', DelChief);

function DelChief() {
	if (confirm(`Ви впевненi\u2753`)) {
		EditChief.action = `delchief.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}