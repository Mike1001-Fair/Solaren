﻿const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn'),
button       = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditPay) {
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm()
		}
	}
});

EditPay.addEventListener('input', ChkForm);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelPay);
RestoreBtn?.addEventListener('click', DelPay);

function ChkForm() {
	with (EditPay) {
		const valid = PayDate.validity.valid && PaySum.validity.valid && ContractId.value != -1;
		SetDisabledButton(button, valid);
	}
}

function DelPay() {
	const MsgText = EditPay.Deleted.value == "True" ? "відновлено" : "видалено";
	if (confirm(`Оплату буде ${MsgText}❗ Ви впевненi\u2753`)) {
		with (EditPay) {
			action = `delpay.asp?PayId=${PayId.value}&Deleted=${Deleted.value}`
		}
	} else {
		event.preventDefault()
	}
}