document.addEventListener("DOMContentLoaded", () => {
	const BackLink = document.getElementById('BackLink'),
	img = document.getElementById('DoneImg');
	BackLink.addEventListener("mouseover", () => img.src = "Images/back.svg");
	BackLink.addEventListener("mouseout", () => img.src = "Images/done.svg");
});