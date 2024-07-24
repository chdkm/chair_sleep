import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.inputTarget.addEventListener("input", () => this.search())
  }

  search() {
    const query = this.inputTarget.value
    if (query.length > 0) {
      fetch(`/posts/search_tag?q=${query}`)
        .then(response => response.json())
        .then(data => this.updateResults(data))
    } else {
      this.resultsTarget.innerHTML = ""
    }
  }

  updateResults(data) {
    this.resultsTarget.innerHTML = data.map(item => `<div>${item}</div>`).join("")
  }
}