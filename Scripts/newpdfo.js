NewPdfo.addEventListener('input', () => {
	with (NewPdfo) {
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !PdfoTax.validity.valid;
	}
})

SbmBtn.addEventListener('click', (event) => {
	confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
});