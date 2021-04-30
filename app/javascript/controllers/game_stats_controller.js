import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  static targets = ['statsContent', 'openStatsButton', 'closeStatsButton'];
  static values = { statsOpen: Boolean, statsLoaded: Boolean, gameId: Number }

  connect() {
    super.connect();
    this.render();
  }

  render() {
    this.statsContentTarget.classList.toggle('hidden', !this.statsOpenValue);
    this.openStatsButtonTarget.classList.toggle('hidden', this.statsOpenValue);
    this.closeStatsButtonTarget.classList.toggle('hidden', !this.statsOpenValue);
  }

  toggleStats() {
    if(!this.statsLoadedValue) {
      this.stimulate('BetsStatsReflex#display', { resolveLate: true }).then(() => {
        this.statsLoadedValue = true;
      });
    }
    this.statsOpenValue = !this.statsOpenValue;
    this.render();
  }
}
