const Inputs = document.querySelectorAll("fieldset[name='SysCfgSet'] > label > input");

document.addEventListener('DOMContentLoaded', () => {
	SetSysCfg(Inputs, EditParameter.SysConfig.value);
	SetMsgVisibility();
});

EditParameter.addEventListener('input', () => {
	with (EditParameter) {
		const isValidIban = isIban(TreasuryAccount.value, TreasuryMfo.value),
		isValidEdrpo = isEdrpoCode(TreasuryCode.value),
		isValidMfo = isMfoCode(TreasuryMfo.value),
		valid = isValidIban && isValidEdrpo && isValidMfo && MsgText.value.search(/\n/) == -1
			&& StartSysDate.validity.valid && HoursLimit.validity.valid
			&& OperMonth.validity.valid && BudgetItem.validity.valid
			&& (!ShowMsg.checked || MsgText.value.length > 0);
		TreasuryAccount.style.color = isValidIban ? "#000000" : "#FF0000";
		TreasuryMfo.style.color = isValidMfo ? "#000000" : "#FF0000";
		TreasuryCode.style.color = isValidEdrpo ? "#000000" : "#FF0000";
		SbmBtn.disabled = !valid;
	}
});

EditParameter.addEventListener('submit', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		with (EditParameter) {
			MsgText.value = MsgText.value.trim();
			SysConfig.value = GetSysCfg(Inputs);
		}
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

ShowMsg.addEventListener('click', SetMsgVisibility);

function SetMsgVisibility() {
	with (EditParameter) {
		MsgText.hidden = !ShowMsg.checked;
		MsgText.hidden ? MsgText.value = null : MsgText.focus();
	}
}

function SetSysCfg(NodeList, cfg) {
	const index = NodeList.length - 1;
	NodeList.forEach((elm, i) => elm.checked = (cfg >> (index - i)) & 1);
}

function GetSysCfg(NodeList) {
	return Array.from(NodeList).reduce((cfg, elm) => (cfg << 1) | elm.checked, 0);
}