FindContract.addEventListener('input', () => {
	with (FindContract) {
		SbmBtn.disabled = (CustomerId.value == -1 && PAN.value == "") || (PAN.value.length > 0 && !isDigit(PAN.value));
	}
});

FindContract.addEventListener('submit', () => {
	const Elements = document.querySelectorAll("input[type='text']");
	Elements.forEach(elm => elm.value = elm.value.trim());
	Loader.Show();
});

CustomerName.addEventListener('input', function() {
	Ajax.GetCustomerList(this, 0);
});