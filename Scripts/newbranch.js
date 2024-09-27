NewBranch.addEventListener('input', () => {
	with (NewBranch) {
		SbmBtn.disabled = !BranchName.validity.valid || !BranchName2.validity.valid 
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

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});