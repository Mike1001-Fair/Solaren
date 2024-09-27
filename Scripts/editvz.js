const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditVz) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditVz.addEventListener('input', () => {
	with (EditVz) {
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !VzTax.validity.valid;
	}
})

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelVz);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelVz);
}

function DelVz() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditVz) {
			action = `delvz.asp?VzId=${VzId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}