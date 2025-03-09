const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditBranch) {
		if (Deleted.value=="True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			const readOnly = ReadOnly.value == "True";
			[SortCode, BranchName1, BranchName2].forEach(element => element.readOnly = readOnly);
			ChkForm();
		}
		Ajax.GetLocalityInfo(LocalityId.value);
	}
});

EditBranch.addEventListener('input', ChkForm);

AreaName.addEventListener('input', function() {
	Ajax.GetAreaList(this)
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

SbmBtn?.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

DelBtn?.addEventListener('click', DelBranch);
RestoreBtn?.addEventListener('click', DelBranch);

function ChkForm() {
	with (EditBranch) {
		const valid = BranchName1.validity.valid && BranchName2.validity.valid
			&& AreaName.validity.valid && AreaId.value != -1
			&& Accountant.validity.valid && LocalityId.value != -1 && LocalityName.validity.valid;
		SetDisabledButton(button, valid);
	}
}

function DelBranch(event) {
	if (confirm(`Ви впевненi\u2753`)) {
		EditBranch.action = `delbranch.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}