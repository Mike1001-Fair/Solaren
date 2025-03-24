"use strict";
const Notify = {
	overlay: null,
	show(msg) {
		if (!this.overlay) {
			// Create overlay
			this.overlay = document.createElement("div");
			this.overlay.id = "notify-overlay";

			// Create window
			const notifyBox = document.createElement("div");
			notifyBox.id = "notify";

			// Create the single info block
			const infoBlock = document.createElement("p"),
			icon = document.createElement("span");
			icon.textContent = 'ℹ️';
			infoBlock.append(icon, msg);

			// Create closeButton
			const closeBtn = document.createElement("div");
			closeBtn.id = "notify-close";
			closeBtn.textContent = "✖";
			closeBtn.addEventListener("click", () => this.close());

			notifyBox.append(infoBlock, closeBtn);
			this.overlay.appendChild(notifyBox);
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