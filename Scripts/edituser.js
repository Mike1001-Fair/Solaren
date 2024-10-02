const SbmBtn = document.getElementById('SbmBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditUser) {
		if (Deleted.value == "True") {
			const Elements = document.querySelectorAll("fieldset");
			Elements.forEach(elm => elm.disabled = true);
			//H3Id.textContent = H3Id.textContent.replace("Редагування", "Перегляд");
		}
		SbmBtn.disabled = true;
	}
});

EditUser.addEventListener('input', () => {
	with (EditUser) {
		SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || !MiddleName.validity.valid
		|| !LoginId.validity.valid || !Pswd.validity.valid;
	}
});

SetPswd.addEventListener('click', (event) => {
	with (EditUser) {
		Pswd.value = User.Pswd;
		SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || !MiddleName.validity.valid
		|| !LoginId.validity.valid || !Pswd.validity.valid;
	}
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
	} else event.preventDefault();
});

DelBtn?.addEventListener('click', DelUser);
RestoreBtn?.addEventListener('click', DelUser);

function DelUser() {
	if (confirm(`Ви впевненi\u2753`)) {
		with (EditUser) {
			action = `deluser.asp?UserId=${UserId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}