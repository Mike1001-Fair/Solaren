"use strict";

const Loader = {
	overlay: null,
    
	Show() {
		if (!this.overlay) {
			const loader = document.createElement('div');
			loader.id = 'loader';
			this.overlay = document.createElement('div');
			this.overlay.id = 'overlay';
			this.overlay.appendChild(loader);
			document.body.appendChild(this.overlay);
		}
	},
    
	Hide() {
		const overlay = document.getElementById('overlay');
		if (overlay) {
			overlay.remove();
		}
		this.overlay = null;
	},
    
	SetClick(selector) {
		document.addEventListener('click', event => {
			if (event.target.matches(selector)) {
				this.Show();
			}
		});
	}
};