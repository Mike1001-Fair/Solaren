const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditPay) {
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditPay.addEventListener('input', () => {
	with (EditPay) {
		SbmBtn.disabled = !PayDate.validity.valid || !PaySum.validity.valid || ContractId.value == -1;
	}
})

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			Loader.Show();
		} else event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelPay);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelPay);
}

function DelPay() {
	const MsgText = EditPay.Deleted.value == "True" ? "відновлено" : "видалено";
	if (confirm(`Оплату буде ${MsgText}❗ Ви впевненi\u2753`)) {
		with (EditPay) {
			action = `delpay.asp?PayId=${PayId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}