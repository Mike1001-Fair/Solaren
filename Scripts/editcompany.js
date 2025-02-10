const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	if (EditCompany.Deleted.value=="True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	}
	Ajax.GetStreetInfo(EditCompany.StreetId.value);
	Ajax.GetLocalityInfo(EditCompany.LocalityId.value);
});

EditCompany.addEventListener('input', () => {
	with (EditCompany) {
		CompanyCode.style.color = isEdrpoCode(CompanyCode.value) ? "#000000" : "#FF0000";
		BankAccount.style.color = isIban(BankAccount.value, MfoCode.value) ? "#000000" : "#FF0000";
		TaxCode.style.color = isTaxCode(TaxCode.value) ? "#000000" : "#FF0000";
		AccountantTaxCode.style.color = isPersonTaxCode(AccountantTaxCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = !CompanyName.validity.valid || CompanyCode.style.color == "rgb(255, 0, 0)"
			|| BankAccount.style.color == "rgb(255, 0, 0)" || !Accountant.validity.valid
			|| !PostIndex.validity.valid || !HouseId.validity.valid || !LogoType.validity.valid
			|| AccountantTaxCode.style.color == "rgb(255, 0, 0)" || TaxCode.style.color == "rgb(255, 0, 0)"
			|| !TaxStatus.validity.valid || !LicenseDate.validity.valid || !LicenseCode.validity.valid
			|| !Phone.validity.valid || !Email.validity.valid || !WebSite.validity.valid
			|| !PerformerTitle.validity.valid || !PerformerName.validity.valid
			|| LocalityId.value == -1 || !LocalityName.validity.valid
			|| StreetId.value == "-1" || !StreetName.validity.valid;
	}
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this)
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});

DelBtn?.addEventListener('click', DelCompany);
RestoreBtn?.addEventListener('click', DelCompany);

function DelCompany() {
	if (confirm("Ви впевненi\u2753")) {
		EditCompany.action = `delcompany.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}