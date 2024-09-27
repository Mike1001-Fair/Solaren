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

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelChief);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelChief);
}

function DelChief() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditChiefTitle) {
			action = `delchieftitle.asp?ChiefTitleId=${ChiefTitleId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}