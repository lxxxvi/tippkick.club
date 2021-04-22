import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["pre", "confirm"];
  static values = { confirmationOpened: Boolean }

  connect() {
    this.render();
  }

  openConfirmation() {
    this.confirmationOpenedValue = true;
    this.render();
  }

  closeConfirmation() {
    this.confirmationOpenedValue = false;
    this.render();
  }

  render() {
    this.confirmTarget.classList.toggle('hidden', !this.confirmationOpenedValue);
    this.preTarget.classList.toggle('hidden', this.confirmationOpenedValue);
  }
}
