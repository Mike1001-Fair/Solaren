FindBudgetCode.addEventListener('submit', () => {
	with (FindBudgetCode) {
		const selectedOption = ChiefId.options[ChiefId.selectedIndex];
		ChiefName.value = selectedOption.text;
	}
});