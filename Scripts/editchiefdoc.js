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

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		const ConfirmText = Resource.GetText("Confirm");
		confirm(ConfirmText) ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelChiefDoc);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelChiefDoc);
}

function DelChiefDoc() {
	const ConfirmText = Resource.GetText("Confirm");
	if (confirm(ConfirmText)) {
		with (EditChiefDoc) {
			action = `delchiefdoc.asp?DocId=${DocId.value}&Deleted=${Deleted.value}`;
		}
		Loader.Show();
	} else event.preventDefault();
}