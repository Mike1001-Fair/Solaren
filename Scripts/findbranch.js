FindBranch.addEventListener('input', () => {
	with (FindBranch) {
		SbmBtn.disabled = !BranchName.validity.valid
	}
});

FindBranch.addEventListener('submit', () => {
	const Elements = document.querySelectorAll("input[type='text']");
	Elements.forEach(elm => elm.value = elm.value.trim());
	Loader.Show();
});
