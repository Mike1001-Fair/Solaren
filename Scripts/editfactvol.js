const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditFactVol) {
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
	ChkForm();
});

EditFactVol.addEventListener('input', ChkForm);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		Loader.Show();
	} else event.preventDefault();
});

DelBtn?.addEventListener('click', DelFactVol);
RestoreBtn?.addEventListener('click', DelFactVol);

function DelFactVol() {
	if (confirm("Ви впевненнi ?")) {
		with (EditFactVol) {
			action = `delfactvol.asp?PayId=${FactVolId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}

function ChkForm() {
	with (EditFactVol) {
		const elm = document.getElementById("SaldoId"),
		retvol    = parseInt(EditFactVol.RetVol.value, 10),
		recvol    = parseInt(EditFactVol.RecVol.value, 10),
		saldo     = recvol - retvol,
		notsaldo  = isNaN(saldo) || (retvol==0 && recvol==0);
		Saldo.value = isNaN(saldo) ? "" : Math.abs(saldo);
		elm.textContent = (notsaldo || !saldo) ? "Сальдо" : saldo > 0 ? "Продаж" : "Покупка";
		if (SbmBtn) {
			SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !RecVol.validity.valid || !RetVol.validity.valid || notsaldo;
		}
	}
}