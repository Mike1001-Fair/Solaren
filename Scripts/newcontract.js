NewContract.addEventListener('input', () => {
	with (NewContract) {
		ContractPower.max = TarifGroupId.value == 0 ? "30" : "50";
		EICode.style.color = isEICode(EICode.value) ? "#000000" : "#FF0000";

		ContractDate.min = ExpDate.value;
		BankAccount.style.color = isAccount(BankAccount.value, MfoCode.value) ? "#000000" : "#FF0000";

		SbmBtn.disabled = !HouseId.validity.valid || !PAN.validity.valid
		|| !isEICode(EICode.value) || !Iban.validity.valid || StreetId.value == -1
		|| LocalityId.value == -1 || !LocalityName.validity.valid
		|| !isAccount(BankAccount.value, MfoCode.value) || (CheckCard.value && !Account.checked && !isCreditCard(CardId.value))
		|| (CheckCard.value && Account.checked  && !isAccount(CardId.value, MfoCode.value))
		|| !ExpDate.validity.valid || !ContractDate.validity.valid
		|| !ContractPower.validity.valid || CustomerId.value == -1;
	}
});

CustomerName.addEventListener('input', function() {
	Ajax.GetCustomerList(this);
});

IbanBox.addEventListener('click', () => {
	with (NewContract) {
		Iban.value = IbanBox.checked ? GetIban(BankAccount.value, MfoCode.value) : "";
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		let Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
	} else event.preventDefault();
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this)
});

function GetIban(acc, mfo) {
	const UACode = "301000";
	let iban = "";
	if (isAccount(acc, mfo)) {
		let bban = mfo + acc.padStart(19, "0"), ChkDigit = 98 - mod97(bban + UACode);
  		iban = "UA" + ChkDigit + bban;
	}
	return iban
}

function mod97(string) {
	let checksum = string.slice(0, 2), fragment;
	for (let offset = 2; offset < string.length; offset += 7) {
		fragment = String(checksum) + string.substring(offset, offset + 7);
		checksum = parseInt(fragment, 10) % 97;
	}
	return checksum;
}