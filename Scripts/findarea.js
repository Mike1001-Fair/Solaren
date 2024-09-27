FindArea.addEventListener('input', () => {
	with (FindArea) {
		SbmBtn.disabled = !AreaName.validity.valid || AreaId.value == -1;
	}
});

AreaName.addEventListener('input', function() {
	Ajax.GetAreaList(this)
});

FindArea.addEventListener('submit', () => {
	FindArea.action = `editarea.asp?AreaId=${AreaId.value}`;
	Loader.Show();
});