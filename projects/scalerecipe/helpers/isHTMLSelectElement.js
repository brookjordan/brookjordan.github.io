/**
 * @param {HTMLSelectElement | EventTarget | null} eventTarget
 * @returns {eventTarget is HTMLSelectElement}
 */
export const isHTMLSelectElement = (eventTarget) =>
  eventTarget instanceof HTMLSelectElement;
