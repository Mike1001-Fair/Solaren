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
		const isValidEdrpo = isEdrpoCode(CompanyCode.value),
		isValidIban = isIban(BankAccount.value, MfoCode.value),
		isValidTaxCode = isTaxCode(TaxCode.value),
		isValidPersonTaxCode = isPersonTaxCode(AccountantTaxCode.value),
		valid = CompanyName.validity.valid && isValidEdrpo && isValidIban && isValidTaxCode && Accountant.validity.valid
			&& PostIndex.validity.valid && HouseId.validity.valid && LogoType.validity.valid && Phone.validity.valid
			&& Email.validity.valid	&& WebSite.validity.valid && PerformerTitle.validity.valid && PerformerName.validity.valid
			&& LocalityId.value != -1 && LocalityName.validity.valid && StreetId.value != -1 && StreetName.validity.valid;
		CompanyCode.style.color = isValidEdrpo ? "#000000" : "#FF0000";
		BankAccount.style.color = isValidIban ? "#000000" : "#FF0000";
		TaxCode.style.color = isValidTaxCode ? "#000000" : "#FF0000";
		AccountantTaxCode.style.color = isValidPersonTaxCode ? "#000000" : "#FF0000";
		[SbmBtn, DelBtn].forEach(btn => btn && (btn.disabled = !valid));
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
	} else {
		event.preventDefault();
	}
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