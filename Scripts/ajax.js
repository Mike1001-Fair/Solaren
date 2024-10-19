"use strict";
const Ajax = {
	minQueryLen: 3,
	maxQueryLen: 5,

	get streetType() {
		return Resource.GetItem("StreetType")
	},

	get localityType() {
		return Resource.GetItem("LocalityType")
	},

	get errLenMsg() {
		const template = Resource.GetText("ErrLenMsg"),
		result = template.replace("{min}", this.minQueryLen);
		return result.replace("{max}", this.maxQueryLen)
	},

	get noDataMsg() {
		return Resource.GetText("NoDataMsg")
	},

	errFetchMsg(error) {
		//console.warn(`Fetch request error: ${error.message}`);
		alert(`Fetch request error: ${error.message}`)
	},


	GetFileList(FolderName) {
		//console.log(`FolderName: ${FolderName}`);
		document.body.style.cursor = "wait";
		fetch(`getfilelist.asp?FolderName=${FolderName}`)
		.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
		.then(data => data.files[0] == "0" ? location.href="accessdenied.asp" : this.SetFileList(data))
		.catch((error) => this.errFetchMsg(error))
		.finally(() => document.body.style.cursor="auto");
	},

	SetFileList(data) {
		const found = data.files[0] != "-1";
		if (found) {
			data.files.forEach(element => {
				let option = document.createElement("option");
				option.value = element;
				FileList.appendChild(option);
			});

			DataFile.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.files.find(element => {
					return element == selectedValue;
				});

				if (selectedElement) {
					DataFile.value = selectedValue;					
					DataFile.title = "";
				}
			});
		} else {
			FileList.textContent = "";
			DataFile.title = this.noDataMsg
		}
	},
 
	GetCustomerList(QueryName) {
		const queryValue = QueryName.value.trim();
		//console.log(`GetCustomerList queryValue.length = ${queryValue.length}`);
		if (queryValue.length < this.minQueryLen || queryValue.length > this.maxQueryLen) {
			CustomerId.value = -1;
			CustomerName.title = this.errLenMsg;
		} else {		
			CustomerList.textContent = "";
			CustomerName.title = "";
			CustomerName.style.cursor = "wait";
			fetch(`getcustomerdata.asp?QueryName=${queryValue}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data[0].CustomerId == 0 ? location.href="accessdenied.asp" : this.SetCustomerList(data))
			.catch((error) => this.errFetchMsg(error))
			.finally(() => CustomerName.style.cursor = "auto");
		}
		return false
	},

	SetCustomerList(data) {
		const found = data[0].CustomerId > 0;
		if (found) {
			data.forEach(element => {
				let option = document.createElement("option");
				option.value = element.CustomerName;
				CustomerList.appendChild(option);
			});

			CustomerName.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.find(element => {
					return element.CustomerName == selectedValue;
				});

				if (selectedElement) {
					CustomerId.value   = selectedElement.CustomerId;
					CustomerName.value = selectedElement.CustomerName;
					CustomerName.title = "";
				}
			});
		} else {
			CustomerList.textContent = "";
			CustomerId.value = -1;
			CustomerName.title = this.noDataMsg
		}
	},

	GetContractList(QueryName) {
		const queryValue = QueryName.value.trim();
		if (queryValue.length < this.minQueryLen || queryValue.length > this.maxQueryLen) {
			ContractId.value = -1;		
			ContractName.title = this.errLenMsg;
		} else {		
			ContractList.textContent = "";
			ContractName.title = "";
			ContractName.style.cursor = "wait";
			fetch(`getcontractdata.asp?QueryName=${queryValue}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data[0].ContractId == 0 ? location.href="accessdenied.asp" : this.SetContractList(data))
			.catch((error) => this.errFetchMsg(error))
			.finally(() => ContractName.style.cursor = "auto");
		}
		return false
	},

	SetContractList(data) {
		const found  = data[0].ContractId > 0;
		if (found) {
			data.forEach(element => {
				let option = document.createElement("option");
				option.value = element.ContractName;
				ContractList.appendChild(option);
			});

			ContractName.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.find(element => {
					return element.ContractName == selectedValue;
				});

				if (selectedElement) {
					ContractId.value   = selectedElement.ContractId;
					ContractName.value = selectedElement.ContractName;
					ContractName.title = "";
				}
			});
		} else {
			ContractList.textContent = "";
			ContractId.value = -1;
			ContractName.title = this.noDataMsg
		}
	},

	GetAreaList(QueryName) {
		const queryValue = QueryName.value.trim();
		//console.log(`GetAreaList queryValue.length = ${queryValue.length}`);
		if (queryValue.length < this.minQueryLen || queryValue.length > this.maxQueryLen) {
			AreaId.value = -1;
			AreaName.title = this.errLenMsg;
		} else {		
			AreaList.textContent = "";
			AreaName.title = "";
			AreaName.style.cursor = "wait";
			fetch(`getareadata.asp?QueryName=${queryValue}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data[0].AreaId == 0 ? location.href="accessdenied.asp" : this.SetAreaList(data))
			.catch((error) => this.errFetchMsg(error))
			.finally(() => AreaName.style.cursor = "auto");
		}
		return false
	},

	SetAreaList(data) {
		const found = data[0].AreaId > 0;
		if (found) {
			data.forEach(element => {
				let option = document.createElement("option");
				option.value = element.AreaName;
				AreaList.appendChild(option);
			});

			AreaName.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.find(element => {
					return element.AreaName == selectedValue;
				});

				if (selectedElement) {
					AreaId.value   = selectedElement.AreaId;
					AreaName.value = selectedElement.AreaName;
					AreaName.title = "";
				}
			});
		} else {
			AreaList.textContent = "";
			AreaId.value = -1;
			AreaName.title = this.noDataMsg
		}
	},

	GetLocalityList(QueryName) {
		const queryValue = QueryName.value.trim();
		if (queryValue.length < this.minQueryLen || queryValue.length > this.maxQueryLen) {
			LocalityId.value = -1;
			LocalityName.title = this.errLenMsg;
		} else {		
			LocalityList.textContent = "";
			LocalityName.style.cursor = "wait";
			fetch(`getlocalitydata.asp?QueryName=${queryValue}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data[0].LocalityId == 0 ? location.href="accessdenied.asp" : this.SetLocalityList(data))
			.catch((error) => this.errFetchMsg(error))
			.finally(() => LocalityName.style.cursor = "auto");
		}
		return false
	},

	SetLocalityList(data) {
		const found = data[0].LocalityId > 0;
		if (found) {
			data.forEach(element => {
				const FullLocalityName = [element.LocalityName, Ajax.localityType[element.LocalityType].toLowerCase()],
				option = document.createElement("option");
				option.value = FullLocalityName.join(' ');
				LocalityList.appendChild(option);
			});

			LocalityName.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.find(element => {
					const FullLocalityName = [element.LocalityName, Ajax.localityType[element.LocalityType].toLowerCase()];
					return FullLocalityName.join(' ') == selectedValue;
				});

				if (selectedElement) {
					//const localityType = Resource.GetItem("LocalityType"),
					const index = selectedElement.LocalityType;
					LocalityId.value         = selectedElement.LocalityId;
					LocalityName.value       = selectedElement.LocalityName;
					//LocalityType.textContent = Ajax.LocalityType[selectedElement.LocalityType];
					LocalityType.textContent = Ajax.localityType[index];
					LocalityName.title       = "";
				}
			});
		} else {
			LocalityList.textContent = "";
			LocalityId.value = -1;
			LocalityName.title = this.noDataMsg
		}
	},

	GetLocalityInfo(LocalityId) {
		if (isDigit(LocalityId)) {
			fetch(`getlocalityinfo.asp?LocalityId=${LocalityId}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => {
				if (data[0].LocalityId > 0) {
					Ajax.SetLocalityInfo(data);
				} else if (data[0].LocalityId == 0) {
					location.href="accessdenied.asp";
				}
			})
			.catch((error) => this.errFetchMsg(error));
		}
		return false
	},

	GetStreetInfo(StreetId) {
		if (isDigit(StreetId)) {
			fetch(`getstreetinfo.asp?StreetId=${StreetId}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => {
				if (data[0].StreetId > 0) {
					Ajax.SetStreetInfo(data);
				} else if (data[0].StreetId == 0) {
					location.href="accessdenied.asp";
				}
			})
			.catch((error) => this.errFetchMsg(error));
		}
		return false
	},

	GetStreetList(QueryName) {
		const queryValue = QueryName.value.trim();
		if (queryValue.length < this.minQueryLen || queryValue.length > this.maxQueryLen) {
			StreetId.value = -1;
			StreetName.title = this.errLenMsg;
		} else {		
			StreetList.textContent = "";
			StreetName.style.cursor = "wait";
			fetch(`getstreetdata.asp?QueryName=${queryValue}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data[0].StreetId == 0 ? location.href="accessdenied.asp" : this.SetStreetList(data))
			.catch((error) => this.errFetchMsg(error))
			.finally(() => StreetName.style.cursor = "auto");			
		}
		return false
	},

	SetStreetList(data) {
		const found = data[0].StreetId > 0;
		if (found) {
			data.forEach(element => {
				const FullStreetName = [element.StreetName, Ajax.streetType[element.StreetType].toLowerCase()],
				option = document.createElement("option");
				option.value = FullStreetName.join(' ');
				StreetList.appendChild(option);
			});

			StreetName.addEventListener("input", function() {
				const selectedValue = this.value,
				selectedElement = data.find(element => {
					const FullStreetName = [element.StreetName, Ajax.streetType[element.StreetType].toLowerCase()];
					return FullStreetName.join(' ') == selectedValue;
				});

				if (selectedElement) {
					StreetId.value         = selectedElement.StreetId;
					StreetName.value       = selectedElement.StreetName;
					StreetType.textContent = Ajax.streetType[selectedElement.StreetType];
					StreetName.title       = "";
				}
			});
		} else {
			StreetList.textContent = "";
			StreetId.value = -1;
			StreetName.title = this.noDataMsg
		}
	},

	GetCustomerInfo(CustomerCode) {
		try {
			fetch(`getcustomerinfo.asp?CustomerCode=${CustomerCode}`)
			.then(response => response.ok ? response.json() : alert(`Помилка fetch-запиту: ${response.status}`))
			.then(data => {
				if (data[0].CustomerId < 0) {
					ResetCustomerInfo();
					alert('Код не знайдено!');
				} else {
					data[0].CustomerId > 0 ? SetCustomerInfo(data) : location.href="accessdenied.asp"
				}
			})
		} catch (error) {
			alert(`Помилка fetch-запиту: ${error.message}`);
		} return false;
	},

	GetContractInfo(AccountId) {
		try {
			fetch(`getcontractinfo.asp?AccountId=${AccountId}`)
			.then(response => response.ok ? response.json() : alert(`Помилка fetch-запиту: ${response.status}`))
			.then(data => {
				if (data[0].ContractId < 0) {
					ResetContractInfo();
					alert('Рахунок не знайдено!');
				} else {
					data[0].ContractId > 0 ? SetContractInfo(data) : location.href="accessdenied.asp"
				}
			})
		} catch (error) {
			alert(`Помилка fetch-запиту: ${error.message}`);
		} return false;
	},

	GetMeterList(ContractId) {
		if (isDigit(ContractId)) {
			document.body.style.cursor="wait";
			fetch(`getmeterlist.asp?ContractId=${ContractId}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => {
				if (data[0].MeterId < 0) {
					alert('Не знайдено жодного лiчильника!');
				} else {
					data[0].MeterId > 0 ? SetMeterList(data) : location.href="accessdenied.asp"
				}
			})
			.catch((error) => this.errFetchMsg(error))
			.finally(() => document.body.style.cursor="auto");
		} else {
			ResetMeterList();
		}
	},

	GetMeterInfo(MeterId, ReportDate) {
		if (isDigit(MeterId)) {
			document.body.style.cursor="wait";
			fetch(`getmeterinfo.asp?ReportDate=${ReportDate}&MeterId=${MeterId}`)
			.then(response => response.ok ? response.json() : Promise.reject(new Error(`${response.status}`)))
			.then(data => data.length > 0 ? SetMeterInfo(data) : location.href="accessdenied.asp")
			.catch((error) => this.errFetchMsg(error))
			.finally(() => document.body.style.cursor="auto");
		} else {
			ResetMeterInfo()
		}
	},

	SetStreetInfo(data) {
		const index = data[0].StreetType;
		StreetType.textContent = this.streetType[index];
	},

	SetLocalityInfo(data) {
		const index = data[0].LocalityType;
		LocalityType.textContent = this.localityType[index];
	}
};