const Alert = {
	overlay: null,
	show(msg) {
		if (!this.overlay) {
			// Create overlay
			this.overlay = document.createElement("div");
			this.overlay.id = "alert-overlay";

			// Create window
			const alertBox = document.createElement("div");
			alertBox.id = "alert";

			// Create infoBlock
			const infoBlock = document.createElement("div");
			infoBlock.id = "alert-info";
			infoBlock.textContent = "ℹ️";

			// Create textBlock
			const text = document.createElement("p");
			text.textContent = msg;

			const mainBox = document.createElement("div");
			mainBox.append(infoBlock, text);

			// Create closeButton
			const closeBtn = document.createElement("div");
			closeBtn.id = "alert-close";
			closeBtn.textContent = "✖";
			closeBtn.addEventListener("click", () => this.close());

			alertBox.append(mainBox, closeBtn);
			this.overlay.appendChild(alertBox);
			document.body.appendChild(this.overlay);
		}
	},

	close() {
		if (this.overlay) {
			this.overlay.remove();
			this.overlay = null;
		}
	}
};