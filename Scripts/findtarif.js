FindTarif.addEventListener('input', () => {
	with (FindTarif) {
		SbmBtn.disabled = !BegDate.validity.valid;
	}
});

FindTarif.addEventListener('submit', () => {
	with (FindTarif) {
		const selectedOption = GroupId.options[GroupId.selectedIndex];
		GroupName.value = selectedOption.text;
	}
	Loader.Show();
});