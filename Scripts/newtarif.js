NewTarif.addEventListener('input', () => {
	with (NewTarif) {
		EndDate.min     = BegDate.value;
   		ExpDateEnd.min  = ExpDateBeg.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid ||
				  !ExpDateBeg.validity.valid || !ExpDateEnd.validity.valid ||
				  !Tarif.validity.valid;
	}
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else event.preventDefault();
	});
}