NewCustomer.addEventListener('input', () => {
	with (NewCustomer) {
		if (CodeType.checked) {
			CustomerCode.style.color = CustomerCode.value.replace(/\s/g,"").length > 7 ? "#000000" : "#FF0000";
		} else CustomerCode.style.color = isPersonTaxCode(CustomerCode.value) ? "#000000" : "#FF0000";

		SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid
		|| !ThirdName.validity.valid || (!CodeType.checked && !isPersonTaxCode(CustomerCode.value)) 
		|| AreaId.value == -1 || LocalityId.value == -1 || StreetId.value == -1
		|| !AreaName.validity.valid || !LocalityName.validity.valid || StreetName.validity.valid
		|| !(CustomerCode.value.replace(/\s/g,"").length > 7) || !Phone.validity.valid || !HouseId.validity.valid;
		//console.log(`AreaId = ${AreaId.value}`);
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