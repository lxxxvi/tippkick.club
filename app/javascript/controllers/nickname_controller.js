import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'
import { moveCursorToEnd } from '../helpers/form_helpers.js'

export default class extends Controller {
  static targets = ["label", "nicknameInput"];

  connect() {
    StimulusReflex.register(this);
  }

  afterReflex () {
    if (this.hasNicknameInputTarget) {
      moveCursorToEnd(this.nicknameInputTarget);
    }
  }

  update() {
    this.stimulate('Nickname#update', this.nicknameInputTarget.value);
  }

  handleKeyboardInput(event) {
    if (event.keyCode == 13) {
      this.update();
    }
  }
}
