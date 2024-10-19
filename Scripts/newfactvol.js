NewFactVol.addEventListener('input', () => {
	with (NewFactVol) {
		const elm = document.getElementById("SaldoId"),
		retvol    = parseInt(RetVol.value, 10),
		recvol    = parseInt(RecVol.value, 10),
		saldo     = recvol - retvol,
		notsaldo  = isNaN(saldo) || (retvol==0 && recvol==0) || !saldo;
		Saldo.value = isNaN(saldo) ? "" : Math.abs(saldo);
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid || !RecVol.validity.valid ||
			!RetVol.validity.valid || notsaldo || ContractId.value == -1;
		elm.textContent = notsaldo ? "Сальдо" : saldo > 0 ? "Продаж" : "Покупка";
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

SbmBtn.addEventListener('click', (event) => {
	confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
});