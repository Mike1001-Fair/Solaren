const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	with (EditOperator) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
		} else {
			ChkForm();
		}
	}
});

EditOperator.addEventListener('input', ChkForm);

SbmBtn?.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else {
			event.preventDefault();
		}
	});

DelBtn?.addEventListener('click', DelOperator);
RestoreBtn?.addEventListener('click', DelOperator);

function ChkForm() {
	with (EditOperator) {
		const isValidEdrpo = isEdrpoCode(EdrpoCode.value),
		valid = SortCode.validity.valid && isValidEdrpo && OperatorName.validity.valid;
		EdrpoCode.style.color = isValidEdrpo ? "#000000" : "#FF0000";
		SetDisabledButton(button, valid);
	}
}

function DelOperator() {
	if (confirm("Ви впевненi\u2753")) {
		EditOperator.action = `deloperator.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}