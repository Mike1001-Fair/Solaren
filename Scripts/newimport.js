const FileList = document.getElementById('FileList');

document.addEventListener('DOMContentLoaded', () => {
	if (FileList) {
		console.log(`FileList.dataset.foldername: ${FileList.dataset.foldername}`);
		Ajax.GetFileList(FileList.dataset.foldername);
	}
});


FileType.addEventListener('change', SetFormAction);

SbmBtn.addEventListener('click', () => {
	fetch(NewImport.SourceFile.value, { method: 'HEAD' })
	.then((response) => response.ok ? response.headers : Promise.reject(new Error(`${response.status}`)))
	.then((headers) => {
		const lastModified = new Date(Date.parse(headers.get('Last-Modified'))),
		fd = formatDate(lastModified),
		cl = headers.get('Content-Length');	
		if (confirm(`Завантажити файл від ${fd} розміром ${cl} байт?`)) {
			with (NewImport) {
				SbmBtn.style.cursor = "wait";
				submit();
			}
		}
	})
	.catch((error) => alert(`Помилка fetch-запиту: ${error.message}`))
});

TestBtn.addEventListener('click', () => {
	const xhr = new XMLHttpRequest();
	xhr.open('HEAD', NewImport.SourceFile.value, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				const d = new Date(Date.parse(xhr.getResponseHeader('Last-Modified'))),
				fd = formatDate(d),
				cl = xhr.getResponseHeader('Content-Length');
				if (confirm(`Протестувати файл вiд ${fd} розмiром ${cl} байт ?`)) {
					document.body.style.cursor="wait";
					NewImport.action = "testindicator.asp";
					NewImport.submit();
				}
			} else alert('Файл для iмпорту не знайдено !');
		}
	};
	xhr.send(null);
});

function formatDate(d) {
	const dar = [d.getDate(), d.getMonth() + 1, d.getFullYear(), d.getHours(), d.getMinutes()],
	fd = dar.map(elm => String(elm).padStart(2, '0')),
	result = [fd.slice(0, 3).join('.'), fd.slice(3).join(':')];
	return result.join(" ")
}

function SetFormAction() {
	const ScriptName = ["loadindicator.asp", "loadpay.asp"],
	fn = ["indicatorimport.txt", "payimport.txt"],
	img = ["importdb.png", "uah1.jpg"];
	with (NewImport) {
		action = ScriptName[FileType.value];
		SourceFile.value = "Import/" + fn[FileType.value];
		ImportImg.src    = "Images/" + img[FileType.value];
		TestBtn.disabled = FileType.value==1;
	}
}  