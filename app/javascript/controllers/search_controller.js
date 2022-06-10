import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["query", "designs"]

  submit() {
    const value = this.queryTarget.value
    fetch(`/?query=${value}`, {
      headers: { accept: 'application/json' }
    }).then((response) => response.text())
      .then(data => console.log(data))

  }
}

const input = document.getElementById("search-input");
const searchBtn = document.getElementById("search-btn");

const expand = () => {
  searchBtn.classList.toggle("close");
  input.classList.toggle("square");
};

searchBtn.addEventListener("click", expand);
