const [SbmBtn, AddBtn] = ['SbmBtn', 'AddBtn'].map(id => document.getElementById(id));

document.addEventListener('DOMContentLoaded', () => {
	AddOrderItem();
	NewOrder.ContractName.focus();	
});

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

NewOrder.addEventListener('input', () => {
	const totalElement = document.getElementById('total');
	with (NewOrder) {
		UpdateTotal();
		SbmBtn.disabled = !ContractName.validity.valid || totalElement.value == 0;
	}
});

SbmBtn.addEventListener('click', (event) => {
	if (confirm("Ви впевненi\u2753")) {
		const table = document.querySelector('#OrderItemsTable tbody'),
		rows = Array.from(table.querySelectorAll('tr')),
		orderData = rows.map(row => {
			const name = row.querySelector('td:nth-child(1) input').value,
			quantity = row.querySelector('td:nth-child(2) input').value;
			return { name, quantity };
		});
		NewOrder.JsonData.value = JSON.stringify(orderData);
		Loader.Show();
	} else {
		event.preventDefault();
	}
});

AddBtn?.addEventListener('click', AddOrderItem);

function AddOrderItem() {
	const table = document.querySelector('#OrderItemsTable tbody'),
	newRow = table.insertRow(),
	cellContents = [
		'<input type="text" name="ItemName" placeholder="Назва" size="20" required>',
		'<input type="number" name="ItemQuantity" min="1" max="9999" placeholder="Кількість" required>',
		'<button type="button" class="RemoveBtn" onclick="RemoveOrderItem(this)" title="Видалити">✖</button>'
	];

	cellContents.forEach(content => {
		const newCell = newRow.insertCell();
		newCell.innerHTML = content;
	});
	newRow.querySelector('input').focus();
}

function RemoveOrderItem(button) {
	const row = button.closest('tr');
	if (row) {
		row.parentNode.removeChild(row);
		UpdateTotal();
	}
}

function UpdateTotal() {
	const table = document.querySelector('#OrderItemsTable tbody'),
	rows = Array.from(table.querySelectorAll('tr')),
	totalElement = document.getElementById('total'),
	total = rows.reduce((sum, row) => {
		const quantity = row.querySelector('td:nth-child(2) input').value;
		return sum + (isNaN(quantity) ? 0 : parseInt(quantity, 10));
	}, 0);
	totalElement.value = isNaN(total) ? '' : total;
}