import { Controller } from '@hotwired/stimulus';

import actualQuery from '../functions/actualQuery';
import isDouble from '../functions/isDouble'
import updateHistory from '../functions/updateHistory'

const STATISTICS_SEND_INTERVAL = 5_000

export default class extends Controller {
  static targets = ['clear_button', 'form', 'input', 'output']

  static values = {
    history: Array,
    isUpdated: Boolean,
    lastRequestTime: Number,
    lastQueryVariants: Array
  }

  connect() {
    this.lastQueryVariants ||= []
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
    const isQueryDouble = isDouble(value, this.lastQueryVariants[this.lastQueryVariants.length - 1])
    const actualQueryValue = isQueryDouble ? actualQuery(value, this.lastQueryVariants) : value
    this.historyValue = updateHistory(actualQueryValue, this.historyValue, isQueryDouble)

    this.renderHistory()
    this.updateQueryVariants(value, isQueryDouble)
    this.isUpdated = true
  }

  updateQueryVariants(value, isQueryDouble) {
    if (value.length < 1) { return }

    isQueryDouble ? this.lastQueryVariants.push(value) : this.lastQueryVariants = [value]
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

    fetch('/article_queries', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrfToken(),
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        article_query: this.historyValue.map((value) => ({ body: value[0], created_at: value[1] }))
      })
    })
    .then((response) => (
      response.ok ? this.isUpdated = false : console.log(response.statusText)
    ))
  }

  clear() {
    fetch('/article_queries', {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': this.csrfToken(),
        'Content-Type': 'application/json'
      }
    })
    .then((response) => {
      if(response.ok) {
        this.historyValue = []
        this.lastQueryVariants = []
        this.isUpdated = false
        this.renderHistory()
      } else {
        console.log(response.statusText)
      }
    })
  }

  csrfToken() {
    return document.getElementsByName("csrf-token")[0].content;
  }
}
