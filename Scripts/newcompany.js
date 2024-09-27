NewCompany.addEventListener('input', () => {
	with (NewCompany) {
		CompanyCode.style.color = isEdrpoCode(CompanyCode.value) ? "#000000" : "#FF0000";
		BankAccount.style.color = isIban(BankAccount.value, MfoCode.value) ? "#000000" : "#FF0000";
		TaxCode.style.color = isTaxCode(TaxCode.value) ? "#000000" : "#FF0000";
		AccountantTaxCode.style.color = isPersonTaxCode(AccountantTaxCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = !CompanyName.validity.valid || CompanyCode.style.color == "rgb(255, 0, 0)"
			|| BankAccount.style.color == "rgb(255, 0, 0)" || !Accountant.validity.valid
			|| !PostIndex.validity.valid || !HouseId.validity.valid
			|| AccountantTaxCode.style.color == "rgb(255, 0, 0)" || TaxCode.style.color == "rgb(255, 0, 0)"
			|| !TaxStatus.validity.valid || !LicenseDate.validity.valid || !LicenseCode.validity.valid
			|| !Phone.validity.valid || !Email.validity.valid || !WebSite.validity.valid
			|| !PerformerTitle.validity.valid || !PerformerName.validity.valid
			|| LocalityId.value == -1 || !LocalityName.validity.valid
			|| StreetId.value == "-1" || !StreetName.validity.valid;
	}
});

SbmBtn.addEventListener('click', () => {
	if (confirm("Ви впевненi\u2753")) {
		let Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this);
});