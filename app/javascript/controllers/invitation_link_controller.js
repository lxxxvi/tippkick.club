import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["linkInput", "copied"]

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
    this.copiedTarget.classList.remove('invisible');
    this.copiedTarget.classList.add('fade-out');
  }

  resetCopied() {
    this.copiedTarget.classList.remove('fade-out');
    this.copiedTarget.classList.add('invisible');
  }
}
