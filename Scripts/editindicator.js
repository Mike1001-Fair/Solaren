const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	ChkForm();
	LoadForm();
});

EditIndicator.addEventListener('input', ChkForm);

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

ContractName.addEventListener('change', () => {
	Ajax.GetMeterList(EditIndicator.ContractId.value);
	ResetMeterInfo();
});

MeterId.addEventListener('change', function() {
	Ajax.GetMeterInfo(this.value, EditIndicator.ReportDate.value);
});

ReportDate.addEventListener('change', function() {
	Ajax.GetMeterInfo(EditIndicator.MeterId.value, this.value);
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', () => {
		confirm("Ви впевненi\u2753") ? Loader.Show() : event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelIndicator);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelIndicator);
}

function LoadForm() {
	with (EditIndicator) {
		const ReportDate = new Date(EditIndicator.ReportDate.value),
		OperDate = new Date(EditIndicator.OperDate.value),
		recval     =+ RecVal.value,
		retval     =+ RetVal.value,
		recvalprev =+ RecValPrev.value,
		retvalprev =+ RetValPrev.value;

		ReportDate.min   = GetNextDate(PrevDate.value);
		RecValPrev.title = FormateDate(PrevDate.value);
		RetValPrev.title = FormateDate(PrevDate.value);
		ContractId.title = "Потужність: " + ContractPower.value;
		MeterId.title    = "Коефiцiєнт: " + Ktf.value;

		ZeroRec.checked  = recval < recvalprev;
		ZeroRet.checked  = retval < retvalprev;

		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
}

function ChkForm() {
	with (EditIndicator) {
	  const msecday    = 86400000,
	   	reportDate = new Date(ReportDate.value),
		prevDate   = new Date(PrevDate.value),
		OperDate   = new Date(EditIndicator.OperDate.value),
		Period     = (reportDate - prevDate)/msecday,
		recval     = parseInt(RecVal.value, 10),
		retval     = parseInt(RetVal.value, 10),
		recvalprev =+ RecValPrev.value,
		retvalprev =+ RetValPrev.value,
		k          =+ Ktf.value;

	    let recsaldo   = (recval - recvalprev)*k,
		retsaldo   = (retval - retvalprev)*k,
		totsaldo   = recsaldo - retsaldo,
		limitsaldo = ContractPower.value * Period * HoursLimit.value,
		notsaldo   = isNaN(totsaldo) || recsaldo < 0 || retsaldo < 0 || (!retsaldo && !recsaldo) || retsaldo > limitsaldo || recval > RecVal.max || retval > RetVal.max;

		if (recsaldo < 0 && ZeroRec.checked) recsaldo += (RecVal.max+1)*k;
		if (retsaldo < 0 && ZeroRet.checked) retsaldo += (RetVal.max+1)*k;

		RecSaldo.value = isNaN(recsaldo) ? "" : recsaldo;
		RecSaldo.style.color = recsaldo < 0 ? "#FF0000" : "";
		
		ZeroRec.disabled = recval >= recvalprev || isNaN(recsaldo);
		if (recval >= recvalprev) ZeroRec.checked = false;
		RetSaldo.value = isNaN(retsaldo) ? "" : retsaldo;
		RetSaldo.style.color = (retsaldo < 0 || retsaldo > limitsaldo) ? "#FF0000" : "";
		RetSaldo.title = isNaN(limitsaldo) ? "" : "Максимум: " + limitsaldo.toFixed(0);
		ZeroRet.disabled = retval >= retvalprev || isNaN(retsaldo);
		if (retval >= retvalprev) ZeroRet.checked = false;
		TotSaldo.value = (ReportDate < OperDate || !notsaldo) ? Math.abs(totsaldo) : "";
		TotSaldo.style.color = notsaldo ? "#FF0000" : "";
		if (Deleted.value != "True" && ViewOnly.value != "True") {
			SbmBtn.disabled = !ReportDate.validity.valid || ContractName.value == '' || ContractId.value == '-1' || notsaldo;
			if (DelBtn) DelBtn.disabled = SbmBtn.disabled;
		}
		Saldo.textContent = (notsaldo || !totsaldo) ? "Сальдо " : totsaldo > 0 ? "Продаж " : "Покупка ";
	}
}

function SetMeterList(data) {
	const ml = EditIndicator.MeterId;
	ml.options.length = 1;
	data.forEach(element => ml.options[ml.options.length] = new Option(element.MeterCode, element.MeterId));
	ml.disabled = false;
}

function SetMeterInfo(data) {
	const limit = Math.pow(10, data[0].Capacity) - 1,
	PrevDateTitle = FormateDate(data[0].PrevDate);
	with (EditIndicator) {
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
	with (EditIndicator) {
		RecVal.value = "";
		RetVal.value = "";
		//RecVal.max = 0;
		//RetVal.max = 0;
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
		SbmBtn.disabled = true;
		if (DelBtn) DelBtn.disabled = true;
	}
}

function ResetMeterList() {
	ResetMeterInfo();
	with (EditIndicator) {
		MeterId.options.length = 1;
		MeterId.disabled = true;
	}
}

function DelIndicator() {
	if (confirm("Ви впевненi\u2753")) {
		with (EditIndicator) {
			action = `delindicator.asp?IndicatorId=${IndicatorId.value}&Deleted=${Deleted.value}`;
		}
		Loader.Show();
	} else event.preventDefault();
}