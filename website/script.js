fetch("https://broef5r40j.execute-api.eu-north-1.amazonaws.com")
    .then(response => response.json())
    .then(data => {
        document.getElementById("counter").innerText = data.count;
    })
    .catch(error => {
        console.error(error);
        document.getElementById("counter").innerText = "Error";
    });