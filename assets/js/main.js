/* Public contact configuration. No network calls, tracking, or browser storage. */
(() => {
  'use strict';
  // To update static fallbacks too, use tools/update-contact.ps1 (see README).
  const CONTACT_EMAIL = 'contact@codeintelligence.ru';
  document.querySelectorAll('[data-contact-email]').forEach((link) => {
    link.textContent = CONTACT_EMAIL;
    link.setAttribute('href', `mailto:${CONTACT_EMAIL}`);
  });
})();
