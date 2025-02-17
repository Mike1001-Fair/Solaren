const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn'),
button       = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditContract) {
		if (Deleted.value == "True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm();
		}
		Ajax.GetLocalityInfo(LocalityId.value);
		Ajax.GetStreetInfo(StreetId.value);	
	}
});

EditContract.addEventListener('input', ChkForm);

CustomerName.addEventListener('input', function() {
	Ajax.GetCustomerList(this);
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

StreetName.addEventListener('input', function() {
	Ajax.GetStreetList(this)
});

IbanBox.addEventListener('click', () => {
	with (EditContract) {
		Iban.value = IbanBox.checked ? GetIban(BankAccount.value, MfoCode.value) : "";
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
 
DelBtn?.addEventListener('click', DelContract);
RestoreBtn?.addEventListener('click', DelContract);

function GetIban(acc, mfo) {
	const UACode = "301000";
	let iban = "";
	if (isAccount(acc, mfo)) {
		let bban = mfo + acc.padStart(19, "0"),
		ChkDigit = 98 - mod97(bban + UACode);
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

function ChkForm() {
	with (EditContract) {
		const isValidPAN = isDigit(PAN.value),
		isValidEICode = isEICode(EICode.value),
		isValidAccount = isAccount(BankAccount.value, MfoCode.value),
		valid = HouseId.validity.valid && PAN.validity.valid && isValidEICode &&
			isValidAccount && StreetId.value != -1 && LocalityId.value != -1 &&
			LocalityName.validity.valid && Iban.validity.valid &&
			ExpDate.validity.valid && ContractDate.validity.valid &&
			ContractPower.validity.valid && CustomerId.value != -1;
				//(CheckCard.value == 'True' && Account.checked && isCreditCard(CardId.value)) &&
				//(CheckCard.value == 'True' && Account.checked  && !isAccount(CardId.value, MfoCode.value)

		ContractPower.max = TarifGroupId.value == 0 ? "30" : "50";
		ContractPower.style.color = +ContractPower.value > ContractPower.max ? "#FF0000" : "#000000";

		PAN.style.color = isValidPAN ? "#000000" : "#FF0000";
		EICode.style.color = isValidEICode ? "#000000" : "#FF0000";
		ContractDate.min = ExpDate.value;

		Iban.style.color = Iban.value.trim().length == 29 ? "#000000" : "#FF0000";
		BankAccount.style.color = isValidAccount ? "#000000" : "#FF0000";
		SetDisabledButton(button, valid);
	}
}

function DelContract() {
	const Msg = EditContract.Deleted.value == "False" ? "видалено та історію розрахунків припинено" : "відновлено";
	if (confirm(`Договiр буде ${Msg}\u2757 Ви впевненi\u2753`)) {
		EditContract.action = `delcontract.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}