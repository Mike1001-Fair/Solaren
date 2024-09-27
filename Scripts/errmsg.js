document.addEventListener("DOMContentLoaded", () => {
	const BackLink = document.getElementById('BackLink'),
	img = document.getElementById('ErrImg');
	BackLink.addEventListener("mouseover", () => img.src = "Images/typrev.gif");
	BackLink.addEventListener("mouseout", () => img.src = "Images/tpattn.gif");
});