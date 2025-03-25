const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditRegion) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditRegion.addEventListener('input', () => {
	with (EditRegion) {
		const valid = SortCode.validity.valid && RegionName.validity.valid;
		SetDisabledButton(button, valid);
	}
})

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelRegion);
RestoreBtn?.addEventListener('click', DelRegion);

function DelRegion() {
	if (confirm(`Ви впевненi❓`)) {
		EditRegion.action = `delregion.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}