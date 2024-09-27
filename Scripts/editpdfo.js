const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditPdfo) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditPdfo.addEventListener('input', () => {
	with (EditPdfo) {
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !PdfoTax.validity.valid;
	}
})

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelPdfo);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelPdfo);
}

function DelPdfo() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditPdfo) {
			action = `delpdfo.asp?PdfoId=${PdfoId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}