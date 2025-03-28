const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	if (EditCompany.Deleted.value=="True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	} else {
		ChkForm();
	}
	Ajax.GetStreetInfo(EditCompany.StreetId.value);
	Ajax.GetLocalityInfo(EditCompany.LocalityId.value);
});

EditCompany.addEventListener('input', ChkForm);
LocalityName.addEventListener('input', () => Ajax.GetLocalityList(LocalityName));
StreetName.addEventListener('input', () => Ajax.GetStreetList(StreetName));

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

function ChkForm() {
	with (EditCompany) {
		const isValidEdrpo = isEdrpoCode(CompanyCode.value),
		isValidIban = isIban(BankAccount.value, MfoCode.value),
		isValidTaxCode = isTaxCode(TaxCode.value),
		isValidPersonTaxCode = isPersonTaxCode(AccountantTaxCode.value),
		valid = CompanyName.validity.valid && isValidEdrpo && isValidIban && isValidTaxCode && isValidPersonTaxCode &&
			Accountant.validity.valid && PostIndex.validity.valid && HouseId.validity.valid && LogoType.validity.valid &&
			Phone.validity.valid && Email.validity.valid && WebSite.validity.valid && PerformerTitle.validity.valid &&
			PerformerName.validity.valid && LocalityId.value != -1 && LocalityName.validity.valid && StreetId.value != -1 &&
			StreetName.validity.valid;
		CompanyCode.style.color = isValidEdrpo ? "#000000" : "#FF0000";
		BankAccount.style.color = isValidIban ? "#000000" : "#FF0000";
		TaxCode.style.color = isValidTaxCode ? "#000000" : "#FF0000";
		AccountantTaxCode.style.color = isValidPersonTaxCode ? "#000000" : "#FF0000";
		SetDisabledButton(button, valid);
	}
}

function DelCompany() {
	if (confirm("Ви впевненi\u2753")) {
		EditCompany.action = `delcompany.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}