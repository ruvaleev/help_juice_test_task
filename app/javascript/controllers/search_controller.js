import { Controller } from '@hotwired/stimulus';

import actualQuery from '../functions/actualQuery';
import isDouble from '../functions/isDouble'
import updateHistory from '../functions/updateHistory'

const STATISTICS_SEND_INTERVAL = 5_000

export default class extends Controller {
  static targets = ['form', 'input', 'output']

  static values = {
    history: Array,
    isUpdated: Boolean,
    lastRequestTime: Number,
    lastQueryVariations: Array
  }

  connect() {
    this.lastQueryVariations ||= []
    setInterval(() => {
      this.sendHistoryToBackend()
    }, STATISTICS_SEND_INTERVAL)
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
      this.addToHistory(this.inputTarget.value)
    }, 200)
  }

  addToHistory(value) {
    const isQueryDouble = isDouble(value, this.lastQueryVariations[this.lastQueryVariations.length - 1])
    const actualQueryValue = isQueryDouble ? actualQuery(value, this.lastQueryVariations) : value
    this.historyValue = updateHistory(actualQueryValue, this.historyValue, isQueryDouble)

    this.renderHistory()
    this.updateQueryVariations(value, isQueryDouble)
    this.isUpdated = true
  }

  updateQueryVariations(value, isQueryDouble) {
    isQueryDouble ? this.lastQueryVariations.push(value) : this.lastQueryVariations = [value]
  }

  renderHistory() {
    this.outputTarget.innerHTML = ''

    this.historyValue.forEach((record) => {
      const element = document.createElement('div')
      element.classList.add('query', 'gray')
      element.innerHTML = record[0]
      this.outputTarget.prepend(element)
    })
  }

  sendHistoryToBackend() {
    if (!this.isUpdated) { return }

    const token = document.getElementsByName(
      "csrf-token"
    )[0].content;

    fetch('/article_queries', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        article_query: this.historyValue.map((value) => ({ body: value[0], created_at: value[1] }))
      })
    })
    . then((response) => (
      response.ok ? this.isUpdated = false : console.log(response.statusText)
    ))
  }
}
