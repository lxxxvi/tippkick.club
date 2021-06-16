import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  static targets = ['content', 'openButton', 'closeButton'];
  static values = { opened: Boolean, loaded: Boolean, userId: Number }

  connect() {
    super.connect();
    this.render();
  }

  render() {
    this.contentTarget.classList.toggle('hidden', !this.openedValue);
    this.openButtonTarget.classList.toggle('hidden', this.openedValue);
    this.closeButtonTarget.classList.toggle('hidden', !this.openedValue);
  }

  toggleHistory() {
    if(!this.loadedValue) {
      this.stimulate('UserTotalPointsHistoryReflex#display', { resolveLate: true }).then(() => {
        this.loadedValue = true;
      });
    }
    this.openedValue = !this.openedValue;
    this.render();
  }
}
