FindCustomer.addEventListener('input', () => {
	with (FindCustomer) {
		SbmBtn.disabled = !CustomerName.validity.valid || CustomerId.value == -1;
	}
});

FindCustomer.addEventListener('submit', () => {
	with (FindCustomer) {
		action = `editcustomer.asp?CustomerId=${CustomerId.value}`;
	}
	Loader.Show();
});

CustomerName.addEventListener('input', function() {
	Ajax.GetCustomerList(this);
});