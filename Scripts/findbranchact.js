FindBranchAct.addEventListener('input', () => {
	with (FindBranchAct) {
		BegMonth.max = EndMonth.value;
		SbmBtn.disabled = !BegMonth.validity.valid || !EndMonth.validity.valid;
	}
});

FindBranchAct.addEventListener('submit', () => {
	with (FindBranchAct) {
		const selectedOption = BranchId.options[BranchId.selectedIndex];
		BranchName.value = selectedOption.text;
	}
});