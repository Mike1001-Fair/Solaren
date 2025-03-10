"use strict";
document.addEventListener('DOMContentLoaded', () => {
	const MainBody = document.getElementById('MainBody'),
	MsgText = document.getElementById('MsgText'),
	LogOut = document.getElementById('LogOut');
	Resource.Load(User.FileName);
	if (LogOut) {
		LogOut.addEventListener('click', (event) => {
			const ConfirmText = Resource.GetText("Confirm");
			confirm(ConfirmText) ? LogOut.href = "logout.asp" : event.preventDefault();
		});
	}

	/* Проверяем, был ли уже показан алерт и прошло ли уже 20 минут
	 localStorage.setItem('alertShown', 'true'); // Устанавливаем флаг в localStorage
	const alertShownTime = localStorage.getItem('alertShownTime');
	if (MainBody && !Empty(MsgText.value) && (!alertShownTime || (Date.now() - alertShownTime > 20 * 60 * 1000))) {
		alert(MsgText.value);
		localStorage.setItem('alertShownTime', Date.now()); // Устанавливаем временную метку показа алерта
	}*/

	Loader.SetClick('li > a:not([href="#"])');
	if (MsgText) {
		alert(MsgText.value);
	}
});

