SbmBtn.addEventListener('click', (event) => {
	const ConfirmText = Resource.GetText("Confirm");
	confirm(ConfirmText) ? Loader.Show() : event.preventDefault();
});