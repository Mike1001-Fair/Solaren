NewUser.addEventListener('input', () => {
	with (NewUser) {
		SbmBtn.disabled = !LastName.validity.valid || !FirstName.validity.valid || !MiddleName.validity.valid
		|| !LoginId.validity.valid || !Pswd.validity.valid;
	}
});

SetPswd.addEventListener('click', (event) => {
	NewUser.Pswd.value = User.Pswd;
	event.preventDefault();
});

ShowPswd.addEventListener('click', (event) => {
	with (NewUser) {
		Pswd.type = Pswd.type == "password" ? "text" : "password";
	}
	event.preventDefault();
});

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const Elements = document.querySelectorAll("input[type='text']");
			Elements.forEach(elm => elm.value = elm.value.trim());
			Loader.Show();
		} else event.preventDefault();
	});
}