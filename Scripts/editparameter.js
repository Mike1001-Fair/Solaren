document.addEventListener('DOMContentLoaded', () => {
	const Inputs = document.querySelectorAll("fieldset[name='SysCfgSet'] > label > input");
	SetSysCfg(Inputs, EditParameter.SysConfig.value);
	HideMsg();
});

EditParameter.addEventListener('input', () => {
	with (EditParameter) {
		TreasuryAccount.style.color = isIban(TreasuryAccount.value, TreasuryMfo.value) ? "#000000" : "#FF0000";
		TreasuryCode.style.color = isEdrpoCode(TreasuryCode.value) ? "#000000" : "#FF0000";
		TreasuryMfo.style.color = isMfoCode(TreasuryMfo.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = !isEdrpoCode(TreasuryCode.value) || !isMfoCode(TreasuryMfo.value)
		|| MsgText.value.search(/\n/) > 0 || !StartSysDate.validity.valid || !HoursLimit.validity.valid
		|| !OperMonth.validity.valid || !isIban(TreasuryAccount.value, TreasuryMfo.value)
		|| !BudgetItem.validity.valid || (ShowMsg.checked && MsgText.value.length == 0);
	}
});

EditParameter.addEventListener('submit', () => {
	if (confirm("Ви впевненi\u2753")) {
		const Inputs = document.querySelectorAll("fieldset[name='SysCfgSet'] > label > input");
		with (EditParameter) {
			MsgText.value = MsgText.value.trim();
			SysConfig.value = GetSysCfg(Inputs);
		}
	} else event.preventDefault();
});

ShowMsg.addEventListener('click', HideMsg);

function HideMsg() {
	with (EditParameter) {
		MsgText.hidden = !ShowMsg.checked;
		MsgText.hidden ? MsgText.value = null : MsgText.focus();
	}
}

function SetSysCfg(NodeList, cfg) {
	const index = NodeList.length - 1;
	NodeList.forEach((elm, i) => elm.checked = cfg & Math.pow(2, index - i));
}

function GetSysCfg(NodeList) {
	let cfgStr = '';
	NodeList.forEach(elm => cfgStr += +elm.checked);
	return parseInt(cfgStr, 2)
}