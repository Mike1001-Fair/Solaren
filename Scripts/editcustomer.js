const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	LoadForm();
	ChkForm();
});

EditCustomer.addEventListener('input', ChkForm);

CodeType.addEventListener('click', () => {
	with (EditCustomer) {
		DocType.textContent = CodeType.checked ? "Паспорт" : "РНОКПП";
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

function LoadForm() {
	with (EditCustomer) {
		if (Deleted.value == "True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
		CodeType.checked = CustomerCode.value.length == 8;
		DocType.textContent = CodeType.checked ? "Паспорт" : "РНОКПП";
	}
	Ajax.GetStreetInfo(EditCustomer.StreetId.value);
	Ajax.GetLocalityInfo(EditCustomer.LocalityId.value);
}

function ChkForm() {
	with (EditCustomer) {
		if (CodeType.checked) {
			CustomerCode.style.color = CustomerCode.value.trim().length == 8 ? "#000000" : "#FF0000";
		} else {
			CustomerCode.style.color = isPersonTaxCode(CustomerCode.value) ? "#000000" : "#FF0000";
		}

		if (SbmBtn) {
			SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || StreetId.value == -1
			|| !ThirdName.validity.valid || (!CodeType.checked && !isPersonTaxCode(CustomerCode.value))
			|| !AreaName.validity.valid || AreaId.value == -1
			|| LocalityId.value == -1 || !LocalityName.validity.valid
			|| !(CustomerCode.value.trim().length > 7) || !Phone.validity.valid
		}
		if (DelBtn) {
			DelBtn.disabled = SbmBtn.disabled;
		}
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