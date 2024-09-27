FindBank.addEventListener('input', () => {
	with (FindBank) {
		SbmBtn.disabled = !BankName.validity.valid;
	}
});

FindBank.addEventListener('submit', () => {
	with (FindBank) {
		BankName.value = BankName.value.trim();
	}
	Loader.Show();
});