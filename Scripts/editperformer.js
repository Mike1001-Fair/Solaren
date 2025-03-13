//const SbmBtn = document.getElementById('SbmBtn');
const [SbmBtn] = ['SbmBtn'].map(id => document.getElementById(id)),
button = [SbmBtn];

document.addEventListener('DOMContentLoaded', () => {
	if (EditPerformer.Deleted.value == "True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	} else {
		ChkForm()
	}
});

EditPerformer.addEventListener('input', ChkForm);

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

function ChkForm() {
	with (EditPerformer) {
		const valid = LastName.validity.valid && FirstName.validity.valid && MiddleName.validity.valid && Phone.validity.valid;
		SetDisabledButton(button, valid);
		//SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || !MiddleName.validity.valid || !Phone.validity.valid;
	}
}
