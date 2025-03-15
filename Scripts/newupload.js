const [SbmBtn] = ['SbmBtn'].map(id => document.getElementById(id)),
button = [SbmBtn];

NewUpLoad.addEventListener('input', () => {
	const valid = NewUpLoad.Files.validity.valid;
	SetDisabledButton(button, valid);
});

SbmBtn.addEventListener('click', (event) => {
	const ConfirmText = Resource.GetText("Confirm");
	confirm(ConfirmText) ? Loader.Show() : event.preventDefault();
});