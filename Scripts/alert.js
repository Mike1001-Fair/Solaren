const Alert = {
	show(msg) {
		if (document.getElementById("alert-overlay")) return;

		// Создаём фон (затемнение)
		this.overlay = document.createElement("div");
		this.overlay.id = "alert-overlay";

		// Создаём окно
		this.alertBox = document.createElement("div");
		this.alertBox.id = "alert";

		// Текст сообщения
		const text = document.createElement("p");
		text.textContent = msg;

		// Кнопка закрытия
		const closeBtn = document.createElement("div");
		closeBtn.id = "alert-close";
		closeBtn.textContent = "✖";
		closeBtn.addEventListener("click", () => this.close());

		// Собираем элементы
		this.alertBox.append(closeBtn, text);
		this.overlay.append(this.alertBox);
		document.body.append(this.overlay);
	},

	close() {
		if (this.overlay) {
			this.overlay.remove();
			this.overlay = null;
		}
	}
};