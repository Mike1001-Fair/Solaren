﻿const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	LoadForm();
	ChkForm();
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
	} else event.preventDefault();
});
 
DelBtn?.addEventListener('click', DelContract);
RestoreBtn?.addEventListener('click', DelContract);

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

function LoadForm() {
	with (EditContract) {
		Ajax.GetLocalityInfo(LocalityId.value);
		Ajax.GetStreetInfo(StreetId.value);
		if (Deleted.value == "True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else 	{
			ContractDate.min = ExpDate.value;
		}
	}
}

function ChkForm() {
	with (EditContract) {
		if (Deleted.value != "True") {
			ContractPower.max = TarifGroupId.value == 0 ? "30" : "50";
			ContractPower.style.color = +ContractPower.value > ContractPower.max ? "#FF0000" : "#000000";

			PAN.style.color = isDigit(PAN.value, 8) ?  "#000000" : "#FF0000";
			EICode.style.color = isEICode(EICode.value) ? "#000000" : "#FF0000";
			ContractDate.min = ExpDate.value;

			Iban.style.color = Iban.value.trim().length == 29 ? "#000000" : "#FF0000";
			BankAccount.style.color = isAccount(BankAccount.value, MfoCode.value) ? "#000000" : "#FF0000";

			SbmBtn.disabled = !HouseId.validity.valid || !PAN.validity.valid || !isEICode(EICode.value)
				|| !isAccount(BankAccount.value, MfoCode.value) || StreetId.value == -1
				|| LocalityId.value == -1 || !LocalityName.validity.valid
				|| (CheckCard.value == 'True' & !Account.checked && !isCreditCard(CardId.value))
				|| (CheckCard.value == 'True' & Account.checked  && !isAccount(CardId.value, MfoCode.value))
				|| !Iban.validity.valid || !ExpDate.validity.valid || !ContractDate.validity.valid
				|| !ContractPower.validity.valid || CustomerId.value == -1;
		}
	}
}

function DelContract() {
	const Msg = EditContract.Deleted.value == "False" ? "видалено, а історію розрахунків припинено" : "відновлено";
	if (confirm(`Договiр буде ${Msg}\u2757 Ви впевненi\u2753`)) {
		with (EditContract) {		
			action = `delcontract.asp?ContractId=${ContractId.value}&Deleted=${Deleted.value}`
		}
		Loader.Show();
	} else event.preventDefault();
}