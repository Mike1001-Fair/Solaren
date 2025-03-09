const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditArea) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm();
		}
	}
});

EditArea.addEventListener('input', ChkForm);

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

function ChkForm() {
	with (EditArea) {
		const valid = SortCode.validity.valid && AreaName.validity.valid;
		SetDisabledButton(button, valid);
	}
}

function DelArea() {
	if (confirm(`Ви впевненi\u2753`)) {
		EditArea.action = `delarea.asp`
		Loader.Show();
	} else {
		event.preventDefault();
	}
}