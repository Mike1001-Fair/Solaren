FindAppLog.addEventListener('input', () => {
	with (FindAppLog) {
		EndDate.min = BegDate.value;
		SbmBtn.disabled = !BegDate.validity.valid || !EndDate.validity.valid;
	}
});

FindAppLog.addEventListener('submit', () => {
	with (FindAppLog) {
		const selectedOption = EventType.options[EventType.selectedIndex];
		EventName.value = selectedOption.text;
	}
});