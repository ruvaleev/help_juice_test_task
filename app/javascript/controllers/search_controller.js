import { Controller } from '@hotwired/stimulus';
import updateHistory from '../functions/updateHistory'

export default class extends Controller {
  static targets = ['form', 'input', 'output']

  static values = {
    history: Array
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
      this.addToHistory(this.inputTarget.value)
    }, 200)
  }

  addToHistory(value) {
    this.historyValue = updateHistory(value, this.historyValue)
    this.renderHistory()
  }

  renderHistory() {
    this.outputTarget.innerHTML = ''

    this.historyValue.forEach((record) => {
      const element = document.createElement('div')
      element.classList.add('query')
      element.innerHTML = record
      this.outputTarget.prepend(element)
    })
  }
}
