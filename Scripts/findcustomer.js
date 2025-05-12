FindCustomer.addEventListener('input', () => {
	with (FindCustomer) {
		SbmBtn.disabled = !CustomerName.validity.valid || CustomerId.value == -1;
	}
});

FindCustomer.addEventListener('submit', () => {
	Loader.Show();
});

CustomerName.addEventListener('input', function() {
	Ajax.GetCustomerList(this);
});