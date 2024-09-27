FindCompany.addEventListener('input', () => {
	with (FindCompany) {
		SbmBtn.disabled = !CompanyName.validity.valid;
	}
});

FindCompany.addEventListener('submit', () => {
	with (FindCompany) {
		CompanyName.value = CompanyName.value.trim();
	}
	Loader.Show();
});