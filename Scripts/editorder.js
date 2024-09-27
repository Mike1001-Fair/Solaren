const SbmBtn = document.getElementById('SbmBtn'),
AddBtn       = document.getElementById('AddBtn'),
DelBtn       = document.getElementById('DelBtn'),
RestoreBtn   = document.getElementById('RestoreBtn');

document.addEventListener('DOMContentLoaded', () => {
	with (EditOrder) {
		WriteOrder(JsonData.value)
		UpdateTotal();
		if (Deleted.value == "True" || ViewOnly.value == "True") {
			const Elements = document.querySelectorAll("fieldset,legend>button");
			Elements.forEach(elm => elm.disabled = true);
		}
	}
});

EditOrder.addEventListener('input', () => {
	with (EditOrder) {
		UpdateTotal();
		SbmBtn.disabled = !ContractName.validity.valid || ContractId.value == -1;
	}
})

ContractName.addEventListener('input', function() {
	Ajax.GetContractList(this);
});

if (AddBtn) {
	AddBtn.addEventListener('click', AddOrderItem);
};

if (SbmBtn) {
	SbmBtn.addEventListener('click', (event) => {
		if (confirm("Ви впевненi\u2753")) {
			const table = document.querySelector('#OrderItemsTable tbody'),
			rows = Array.from(table.querySelectorAll('tr')),
			orderData = rows.map(row => {
				const name = row.querySelector('td:nth-child(1) input').value,
				quantity = row.querySelector('td:nth-child(2) input').value;
				return { name, quantity };
			});
			EditOrder.JsonData.value = JSON.stringify(orderData);
			Loader.Show();
		} else event.preventDefault();
	});
}

if (DelBtn) {
	DelBtn.addEventListener('click', DelOrder);
}

if (RestoreBtn) {
	RestoreBtn.addEventListener('click', DelOrder);
}

function DelOrder() {
	const MsgText = EditOrder.Deleted.value == "True" ? "відновлено" : "видалено";
	if (confirm(`Замовлення буде ${MsgText}. Ви впевненi\u2753`)) {
		with (EditOrder) {
			action = `delorder.asp?OrderId=${OrderId.value}&Deleted=${Deleted.value}`
		}
	} else event.preventDefault();
}

function WriteOrder(JsonData) {
	const Order = JSON.parse(JsonData),
	table = document.querySelector('#OrderItemsTable tbody');
	Order.forEach(order => {
		const newRow = table.insertRow();
		cellContents = [
			`<input type="text" name="ItemName" placeholder="Назва" value="${order.name}" size="20" required>`,
			`<input type="number" name="ItemQuantity" min="1" max="9999" placeholder="Кількість" value="${order.quantity}" required>`,
			`<button type="button" class="RemoveBtn" onclick="RemoveOrderItem(this)" title="Видалити">&#10060;</button>`
		];
		cellContents.forEach(content => {
			const newCell = newRow.insertCell();
			newCell.innerHTML = content;
		});
	});
}

function AddOrderItem() {
	const table = document.querySelector('#OrderItemsTable tbody'),
	newRow = table.insertRow(),
	cellContents = [
		'<input type="text" name="ItemName" placeholder="Назва" size="20" required>',
		'<input type="number" name="ItemQuantity" min="1" max="9999" placeholder="Кількість" required>',
		'<button type="button" class="RemoveBtn" onclick="RemoveOrderItem(this)" title="Видалити">&#10060;</button>'
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