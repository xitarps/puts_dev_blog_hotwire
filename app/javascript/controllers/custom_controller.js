import { Controller } from "@hotwired/stimulus"
import { useDebounce } from 'stimulus-use'

export default class extends Controller {
  static targets = [ 'hint' ]
  static debounces = ['update_hint']

  connect() {
    // alert('conectado')
    useDebounce(this, { wait: 2000 })
  }

  update_hint(event) {
    this.hintTarget.textContent = event.target.value
  }
}
