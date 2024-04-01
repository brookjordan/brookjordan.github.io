/**
 * @param {HTMLInputElement | EventTarget | null} eventTarget
 * @returns {eventTarget is HTMLInputElement}
 */
export const isHTMLInputElement = (eventTarget) =>
  eventTarget instanceof HTMLInputElement;
