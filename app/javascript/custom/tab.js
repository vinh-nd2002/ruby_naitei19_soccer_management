const openElement = (elementName) => {
    const components = document.querySelectorAll(".form");
    components.forEach(element => {
        element.style.display = "none";
    });

    const selectedComponent = document.getElementById(elementName);
    if (selectedComponent) {
        selectedComponent.style.display = "block";
    }
}

window.openElement = openElement
