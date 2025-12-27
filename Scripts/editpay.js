const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	if (EditPay.Deleted.value == "True" || EditPay.ViewOnly.value == "True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	} else {
		ChkForm()
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
		EditPay.action = `delpay.asp`
	} else {
		event.preventDefault()
	}
}