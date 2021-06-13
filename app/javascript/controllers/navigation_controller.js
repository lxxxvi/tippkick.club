import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    "mobileMenu",
    "mobileMenuToggler",
    "mobileMenuIconClosed",
    "mobileMenuIconOpened"
  ];

  connect() {
    this.renderMobileMenu();
  }

  renderMobileMenu() {
    if (this.displayMobileMenu()) {
      this.mobileMenuTarget.classList.remove('hidden');
      this.mobileMenuIconClosedTarget.classList.add('hidden');
      this.mobileMenuIconOpenedTarget.classList.remove('hidden');
    } else {
      this.mobileMenuTarget.classList.add('hidden');
      this.mobileMenuIconClosedTarget.classList.remove('hidden');
      this.mobileMenuIconOpenedTarget.classList.add('hidden');
    }
  }

  toggleMobileMenu() {
    this.switchMobileMenuAriaExpanded();
    this.renderMobileMenu();
  }

  switchMobileMenuAriaExpanded() {
    this.setMobileMenuAriaExpanded(!this.displayMobileMenu());
  };

  displayMobileMenu() {
    return (this.getMobileMenuAriaExpanded() === 'true');
  }

  setMobileMenuAriaExpanded(boolean) {
    this.mobileMenuTogglerTarget.setAttribute('aria-expanded', String(boolean));
  }

  getMobileMenuAriaExpanded() {
    return this.mobileMenuTogglerTarget.getAttribute('aria-expanded');
  }
}
