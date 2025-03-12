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

			// Create the single info block
			const infoBlock = document.createElement("p"),
			icon = document.createElement("span");
			icon.textContent = 'ℹ️';
			icon.id = "alert-icon";
			infoBlock.append(icon, msg);

			// Create closeButton
			const closeBtn = document.createElement("div");
			closeBtn.id = "alert-close";
			closeBtn.textContent = "✖";
			closeBtn.addEventListener("click", () => this.close());

			alertBox.append(infoBlock, closeBtn);
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