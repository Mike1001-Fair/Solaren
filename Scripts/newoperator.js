NewOperator.addEventListener('input', () => {
	with (NewOperator) {
		EdrpoCode.style.color = isEdrpoCode(EdrpoCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = !SortCode.validity.valid || EdrpoCode.style.color == "rgb(255, 0, 0)" || !OperatorName.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm(`Ви впевненi❓`)) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});