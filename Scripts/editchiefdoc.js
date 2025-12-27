const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditChiefDoc) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditChiefDoc.addEventListener('input', () => {
	with (EditChiefDoc) {
		SbmBtn.disabled = !SortCode.validity.valid || !DocName.validity.valid;
	}
});

SbmBtn?.addEventListener('click', (event) => {
	const ConfirmText = Resource.GetText("Confirm");
	confirm(ConfirmText) ? Loader.Show() : event.preventDefault();
});

DelBtn?.addEventListener('click', DelChiefDoc);
RestoreBtn?.addEventListener('click', DelChiefDoc);


function DelChiefDoc() {
	const ConfirmText = Resource.GetText("Confirm");
	if (confirm(ConfirmText)) {
		EditChiefDoc.action = `delchiefdoc.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}