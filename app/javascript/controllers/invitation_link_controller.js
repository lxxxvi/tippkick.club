import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  static targets = ["linkInput", "copied", "linkRefreshed"];

  copyToClipboard() {
    this.copyLinkInputToClipboard();
    this.animateCopied();
  }

  copyLinkInputToClipboard() {
    this.linkInputTarget.select();
    this.linkInputTarget.setSelectionRange(0, 99999);
    document.execCommand("copy");
  }

  animateCopied() {
    this.copiedTarget.addEventListener('animationend', () => this.resetCopied());
    this.copiedTarget.classList.remove('hidden');
    this.copiedTarget.classList.add('fade-out');
  }

  resetCopied() {
    this.copiedTarget.classList.remove('fade-out');
    this.copiedTarget.classList.add('hidden');
  }

  animateLinkRefreshed() {
    this.linkRefreshedTarget.addEventListener('animationend', () => this.resetLinkRefreshed());
    this.linkRefreshedTarget.classList.remove('hidden');
    this.linkRefreshedTarget.classList.add('fade-out');
  }

  resetLinkRefreshed() {
    this.linkRefreshedTarget.classList.remove('fade-out');
    this.linkRefreshedTarget.classList.add('hidden');
  }

  refresh() {
    this.stimulate('InvitationLinkReflex#refresh', { resolveLate: true }).then(() => {
      this.animateLinkRefreshed();
    });
  }
}
