NewVz.addEventListener('input', () => {
	with (NewVz) {
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !VzTax.validity.valid;
	}
})

SbmBtn.addEventListener('click', (event) => {
	confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
});