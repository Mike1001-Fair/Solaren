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