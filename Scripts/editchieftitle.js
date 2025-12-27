const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditChiefTitle) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditChiefTitle.addEventListener('input', () => {
	with (EditChiefTitle) {
		SbmBtn.disabled = !Title1.validity.valid || !Title2.validity.valid
		|| !Title3.validity.valid || !RankId.validity.valid;
	}

})

SbmBtn?.addEventListener('click', (event) => {
	const ConfirmText = Resource.GetText("Confirm");
	confirm(ConfirmText) ? Loader.Show() : event.preventDefault();
});

DelBtn?.addEventListener('click', DelChief);
RestoreBtn?.addEventListener('click', DelChief);

function DelChief() {
	if (confirm(`Ви впевненi\u2753`)) {
		EditChiefTitle.action = `delchieftitle.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}