NewIndicator.addEventListener('input',  () => {
	with (NewIndicator) {
	  const msecday    = 864e5,
		reportDate = new Date(ReportDate.value),
		prevDate   = new Date(PrevDate.value),
		OperDate   = new Date(NewIndicator.OperDate.value),
		EndDate    = new Date(NewIndicator.EndDate.value),
		Period     = (reportDate - prevDate)/msecday,
		recval     = parseInt(RecVal.value, 10),
		retval     = parseInt(RetVal.value, 10),
		recvalprev =+ RecValPrev.value,
		retvalprev =+ RetValPrev.value,
		k          = Ktf.value;

	    let recsaldo   = (recval - recvalprev) * k,
		retsaldo   = (retval - retvalprev) * k,
		totsaldo   = recsaldo - retsaldo,
		limitsaldo = ContractPower.value * Period * HoursLimit.value,
		notsaldo   = isNaN(totsaldo) || recsaldo < 0 || retsaldo < 0 || (!retsaldo && !recsaldo) 
				|| retsaldo > limitsaldo || recval > RecVal.max || retval > RetVal.max;

		if (recsaldo < 0 && ZeroRec.checked) {
			recsaldo += (RecVal.max + 1) * k;
		}

		if (retsaldo < 0 && ZeroRet.checked) {
			retsaldo += (RetVal.max + 1) * k;
		}

		RecSaldo.value = isNaN(recsaldo) ? "" : recsaldo;
		RecSaldo.style.color = recsaldo < 0 ? "#FF0000" : "#000000";
		ZeroRec.disabled = recval >= recvalprev || isNaN(recsaldo);
		if (recval >= recvalprev) {
			ZeroRec.checked = false;
		}

		RetSaldo.value = isNaN(retsaldo) ? "" : retsaldo;
		RetSaldo.style.color = (retsaldo < 0 || retsaldo > limitsaldo) ? "#FF0000" : "#000000";
		RetSaldo.title = isNaN(limitsaldo) ? "" : "Максимум: " + limitsaldo.toFixed(0);
		ZeroRet.disabled = retval >= retvalprev || isNaN(retsaldo);
		if (retval >= retvalprev) {
			ZeroRet.checked = false;
		}

		TotSaldo.value = isNaN(totsaldo) ? "" : Math.abs(totsaldo);
		TotSaldo.style.color = notsaldo ? "#FF0000" : "#000000";
		SbmBtn.disabled = !ReportDate.validity.valid || MeterId.value == "" || notsaldo;
		//SbmBtn.textContent = SbmBtn.disabled ? "Створити" : "✅Створити";
		Saldo.textContent = (notsaldo || !totsaldo) ? "Сальдо " : totsaldo > 0 ? "Продаж " : "Покупка ";
	}
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

ContractName.addEventListener('change', () => {
	Ajax.GetMeterList(NewIndicator.ContractId.value);
	ResetMeterInfo();
});

MeterId.addEventListener('change', function() {
	Ajax.GetMeterInfo(this.value, NewIndicator.ReportDate.value);
});

ReportDate.addEventListener('change', function() {
	Ajax.GetMeterInfo(NewIndicator.MeterId.value, this.value);
});

function SetMeterList(data) {
	if (data[0].MeterId == -1) {
		ResetMeterInfo();
		with (NewIndicator.MeterId) {
			options.length = 0;
			disabled = true;
		}
		Notify.show('Не знайдено жодного лiчильника❗');
	} else {
		with (NewIndicator.MeterId) {
			options.length = 1;
			data.forEach(element => options[options.length] = new Option(element.MeterCode, element.MeterId));
			disabled = false;
		}
	}
}

function SetMeterInfo(data) {
	//const limit = 10 ** data[0].Capacity - 1,
	const limit = Math.pow(10, data[0].Capacity) - 1,
	PrevDateTitle = FormateDate(data[0].PrevDate);
	with (NewIndicator) {
		Ktf.value = data[0].kTransForm;
		RecVal.max = limit;
		RetVal.max = limit;
		RecValPrev.value = data[0].RecVal;
		RetValPrev.value = data[0].RetVal;
		PrevDate.value   = data[0].PrevDate;
		RecValPrev.title = PrevDateTitle;
		RetValPrev.title = PrevDateTitle;
		ContractPower.value = data[0].ContractPower;
		MeterId.title = "Коефiцiєнт: " + data[0].kTransForm;
		ContractName.title = "Потужність: " + data[0].ContractPower;
		ReportDate.min = GetNextDate(data[0].PrevDate);
		ReportDate.disabled = false;
		IndicatorSet.disabled = false;
		ResultSet.disabled = false;
		RecVal.focus();
	}
}

function ResetMeterInfo() {
	with (NewIndicator) {
		RecVal.value = "";
		RetVal.value = "";
		RecValPrev.value = "";
		RetValPrev.value = "";
		RecValPrev.title = "";
		RetValPrev.title = "";
		ContractPower.value = null;
		ContractId.title = "";
		MeterId.title = "";
		ZeroRec.checked = false;
		ZeroRet.checked = false;
		RecSaldo.value = "";
		RetSaldo.value = "";
		TotSaldo.value = "";
		ReportDate.disabled = true;
		IndicatorSet.disabled = true;
		ResultSet.disabled = true;
	}
}

function ResetMeterList() {
	ResetMeterInfo();
	with (NewIndicator.MeterId) {
		options.length = 1;
		disabled = true;
	}
}