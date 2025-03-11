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

			// Create closeButton
			const closeBtn = document.createElement("div");
			closeBtn.id = "alert-close";
			closeBtn.textContent = "✖";
			closeBtn.addEventListener("click", () => this.close());
			
			alertBox.append(infoBlock, text, closeBtn);
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