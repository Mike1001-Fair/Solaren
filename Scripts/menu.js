"use strict";
document.addEventListener('DOMContentLoaded', () => {
	const [MsgText, LogOut] = ['MsgText', 'LogOut'].map(id => document.getElementById(id));
	Resource.Load(User.FileName);

	LogOut?.addEventListener('click', (event) => {
		const ConfirmText = Resource.GetText("Confirm");
		confirm(ConfirmText) ? LogOut.href = "logout.asp" : event.preventDefault();
	});
	Loader.SetClick('li > a:not([href="#"])');
	if (MsgText) {
		Notify.show(MsgText.value);
	}
});

window.addEventListener("pageshow", event => {
	if (event.persisted) {
		Loader.Hide();
	}
});

/* Проверяем, был ли уже показан алерт и прошло ли уже 20 минут
 localStorage.setItem('alertShown', 'true'); // Устанавливаем флаг в localStorage
const alertShownTime = localStorage.getItem('alertShownTime');
if (MainBody && !Empty(MsgText.value) && (!alertShownTime || (Date.now() - alertShownTime > 20 * 60 * 1000))) {
	alert(MsgText.value);
	localStorage.setItem('alertShownTime', Date.now()); // Устанавливаем временную метку показа алерта
}*/


