NewCustomer.addEventListener('input', () => {
	with (NewCustomer) {
		if (CodeType.checked) {
			CustomerCode.style.color = CustomerCode.value.replace(/\s/g,"").length > 7 ? "#000000" : "#FF0000";
		} else {
			CustomerCode.style.color = isPersonTaxCode(CustomerCode.value) ? "#000000" : "#FF0000";
		}

		SbmBtn.disabled = !(LastName.validity.valid && FirstName.validity.valid && ThirdName.validity.valid
				&& (CodeType.checked ? CustomerCode.value.replace(/\s/g,"").length > 7 : isPersonTaxCode(CustomerCode.value)) 
				&& Phone.validity.valid && AreaId.value != -1 && LocalityId.value != -1 && StreetId.value != -1 && HouseId.validity.valid);
	}

});

SbmBtn.addEventListener('click', () => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
	} else event.preventDefault();
});

AreaName.addEventListener('input', function() {
	Ajax.GetAreaList(this)
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this);
});

CodeType.addEventListener('click', () => {
	with (NewCustomer) {
		DocType.textContent = CodeType.checked ? "Паспорт" : "РНОКПП";
		CustomerCode.focus();
	}
});