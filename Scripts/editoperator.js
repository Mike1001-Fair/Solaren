const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditOperator) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditOperator.addEventListener('input', () => {
	with (EditOperator) {
		EdrpoCode.style.color = isEdrpoCode(EdrpoCode.value) ? "#000000" : "#FF0000";
		SbmBtn.disabled = !SortCode.validity.valid || EdrpoCode.style.color == "rgb(255, 0, 0)" || !OperatorName.validity.valid;
	}
})

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
	DelBtn.addEventListener('click', DelOperator);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelOperator);
}

function DelOperator() {
	if (confirm("Ви впевненi\u2753")) {
		with (EditOperator) {
			action = `deloperator.asp?OperatorId=${OperatorId.value}&Deleted=${Deleted.value}`;
		}
		Loader.Show();
	} else event.preventDefault();
}