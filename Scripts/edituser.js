const [SbmBtn, DelBtn, RestoreBtn] = ['SbmBtn', 'DelBtn', 'RestoreBtn'].map(id => document.getElementById(id)),
button = [SbmBtn, DelBtn];

document.addEventListener('DOMContentLoaded', () => {
	if (EditUser.Deleted.value == "True") {
		const Elements = document.querySelectorAll("fieldset");
		Elements.forEach(elm => elm.disabled = true);
	} else {
		ChkForm()
	}
});

EditUser.addEventListener('input', ChkForm);

SetPswd.addEventListener('click', (event) => {
	EditUser.Pswd.value = User.Pswd;
	ChkForm();
});

ShowPswd.addEventListener('click', (event) => {
	with (EditUser) {
		Pswd.type = Pswd.type == "password" ? "text" : "password";
	}
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

DelBtn?.addEventListener('click', DelUser);
RestoreBtn?.addEventListener('click', DelUser);

function ChkForm() {
	with (EditUser) {
		const valid = LastName.validity.valid && FirstName.validity.valid && MiddleName.validity.valid
			&& LoginId.validity.valid && Pswd.validity.valid;
		SetDisabledButton(button, valid);
	}
}

function DelUser() {
	if (confirm("Ви впевненi\u2753")) {
		EditUser.action = `deluser.asp`;
		Loader.Show();
	} else {
		event.preventDefault();
	}
}