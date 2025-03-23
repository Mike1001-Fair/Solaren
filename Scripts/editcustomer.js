const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditCustomer) {
		if (Deleted.value == "True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm();
		}
		CodeType.checked = CustomerCode.value.length == 8;
		DocType.textContent = CodeType.checked ? "Паспорт" : "РНОКПП";
	}
	Ajax.GetStreetInfo(EditCustomer.StreetId.value);
	Ajax.GetLocalityInfo(EditCustomer.LocalityId.value);
});

EditCustomer.addEventListener('input', ChkForm);

CodeType.addEventListener('click', () => {
	with (EditCustomer) {
		DocType.textContent = CodeType.checked ? "Паспорт" : "РНОКПП";
		CustomerCode.maxLength = CodeType.checked ? 8 : 10;
		CustomerCode.focus();
	}
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

DelBtn?.addEventListener('click', DelCustomer);
RestoreBtn?.addEventListener('click', DelCustomer);

AreaName.addEventListener('input', function() {
	Ajax.GetAreaList(this)
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this)
});

function ChkForm() {
	with (EditCustomer) {
		const isValidPersonTaxCode = CodeType.checked ? CustomerCode.value.trim().length == 8 : isPersonTaxCode(CustomerCode.value),
		valid = LastName.validity.valid && FirstName.validity.valid && ThirdName.validity.valid && StreetName.validity.valid &&
			StreetId.value != -1 && isValidPersonTaxCode && AreaName.validity.valid && AreaId.value != -1 &&
			LocalityId.value != -1 && LocalityName.validity.valid && Phone.validity.valid;

		CustomerCode.style.color = isValidPersonTaxCode ? "#000000" : "#FF0000";
		SetDisabledButton(button, valid);
	}
}

function DelCustomer() {
	const MsgText = EditCustomer.Deleted.value == "True" ? "відновлено" : "видалено";
	if (confirm(`Анкету споживача та усі його договора буде ${MsgText}\u2757 Ви впевненi\u2753`)) {
		EditCustomer.action = `delcustomer.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}