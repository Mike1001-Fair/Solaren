const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditBranch) {
		if (Deleted.value=="True") {
			let Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			const readOnly = ReadOnly.value == "True";
			SortCode.readOnly    = readOnly;
			BranchName1.readOnly = readOnly;
			BranchName2.readOnly = readOnly;
		}
		Ajax.GetLocalityInfo(LocalityId.value);
	}
});

EditBranch.addEventListener('input', () => {
	with (EditBranch) {
		SbmBtn.disabled = !BranchName1.validity.valid || !BranchName2.validity.valid
		|| !AreaName.validity.valid || AreaId.value == -1
		|| !Accountant.validity.valid || LocalityId.value == -1 || !LocalityName.validity.valid;
	}	
});

AreaName.addEventListener('input', function() {
	Ajax.GetAreaList(this)
});

LocalityName.addEventListener('input', function() {
	Ajax.GetLocalityList(this)
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelBranch);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelBranch);
}

function DelBranch() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditBranch) {
			action = `delbranch.asp?BranchId=${BranchId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}