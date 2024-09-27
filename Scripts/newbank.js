NewBank.addEventListener('input', () => {
	with (NewBank) {
		MfoCode.style.color = isMfoCode(MfoCode.value) ? "#000000" : "#FF0000";
		EdrpoCode.style.color = isEdrpoCode(EdrpoCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = EdrpoCode.style.color == "rgb(255, 0, 0)" || MfoCode.style.color == "rgb(255, 0, 0)" || !BankName.validity.valid;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const Elements = document.querySelectorAll("input[type='text']");
		Elements.forEach(elm => elm.value = elm.value.trim());
		Loader.Show();
	} else event.preventDefault();
});