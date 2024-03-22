window.onload = () => {
    // Find the table
    const dataTable = document.querySelector('table')

    // Give it an ID so it's easier to work with for CSS or subsequent JS
    dataTable.id = 'report-table'

    // Move the first row into a THEAD element that PowerShell doesn't add but is necessary for sorting
    const headerRow = dataTable.querySelector('tr:nth-child(1)')
    const thead = document.createElement('thead')
    thead.appendChild(headerRow)
    dataTable.prepend(thead)

    // Mark the first row as numeric so it sorts correctly
    const numberRow = document.querySelector('#report-table tr:nth-child(1)').querySelector(':nth-child(1)')
    numberRow.setAttribute('data-tsorter', 'numeric')
    
    // http://www.terrill.ca/sorting/
    // Make it sortable
    const sorter = tsorter.create('report-table')

    var rows = document.getElementsByTagName("table")[0].getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    // loops through each row
    for (i = 0; i < rows.length; i++) {
        cells = rows[i].getElementsByTagName('td');
	console.log(cells)
        if (cells[6].innerHTML == 'Failed'){
	    switch (cells[7].innerHTML) {
                case 'High':
                    rows[i].className = "red";
                    break;
                case 'Medium':
                    rows[i].className = "orange";
                    break;
                case 'Low':
                    rows[i].className = "yellow";
                    break;
            }
        }
    }
}