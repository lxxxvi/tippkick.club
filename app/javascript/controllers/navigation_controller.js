import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    "mobileMenu",
    "mobileMenuToggler",
    "mobileMenuIconClosed",
    "mobileMenuIconOpened",
    "profileMenu",
    "profileMenuToggler"
  ];

  connect() {
    this.renderMobileMenu();
    this.renderProfileMenu();
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

  renderProfileMenu() {
    if(this.hasProfileMenuTarget) {
      if (this.displayProfileMenu()) {
        this.profileMenuTarget.classList.remove('hidden');
      } else {
        this.profileMenuTarget.classList.add('hidden');
      }
    }
  }

  toggleMobileMenu() {
    this.switchMobileMenuAriaExpanded();
    this.renderMobileMenu();
  }

  toggleProfileMenu() {
    this.switchProfileMenuAriaExpanded();
    this.renderProfileMenu();
  }

  switchMobileMenuAriaExpanded() {
    this.setMobileMenuAriaExpanded(!this.displayMobileMenu());
  };

  switchProfileMenuAriaExpanded() {
    this.setProfileMenuAriaExpanded(!this.displayProfileMenu());
  };

  displayMobileMenu() {
    return (this.getMobileMenuAriaExpanded() === 'true');
  }

  displayProfileMenu() {
    return (this.getProfileMenuAriaExpanded() === 'true');
  }

  setMobileMenuAriaExpanded(boolean) {
    this.mobileMenuTogglerTarget.setAttribute('aria-expanded', String(boolean));
  }

  setProfileMenuAriaExpanded(boolean) {
    this.profileMenuTogglerTarget.setAttribute('aria-expanded', String(boolean));
  }

  getMobileMenuAriaExpanded() {
    return this.mobileMenuTogglerTarget.getAttribute('aria-expanded');
  }

  getProfileMenuAriaExpanded() {
    return this.profileMenuTogglerTarget.getAttribute('aria-expanded');
  }
}
