function addInstallPWAModal(beforeInstallPromptEvent) {
  let promptModal = document.createElement('div');
  promptModal.style.cssText = `
    position: fixed;
    bottom: 20px;
    left: 50%;
    z-index: 999999999;
    transform: translateX(-50%);
    background: white;
    padding: 20px 30px;
    font-size: 0.8em;
    filter: drop-shadow(2px 4px 6px rgba(0,0,0,0.2));
  `;
  promptModal.innerHTML = `
    <button
      class="install-pwa-dismiss"
      type="button"
      style="
          position: absolute;
          left: 100%;
          top: 0;
          border: 0;
          font-size: 2em;
          padding: 0 0.5em;
      "
    >
      ×
    </button>

    <h1
      style="
        font-size: 1.5em;
        margin: 0;
      "
    >
      Add to your homescreen?
    </h1>
    
    <button
      class="install-pwa-accept"
      type="button"
      style="
        width: 100%;
        font-size: 1.5em;
        margin: 0.5em 0;
      "
    >
      Hell yeah!
    </button>

    <button
      class="install-pwa-decline"
      type="button"
      style="
        width: 100%;
        font-size: 1.5em;
      "
    >
      No thanks.
    </button>
  `;
  promptModal.querySelector('.install-pwa-accept').addEventListener('click', event => {
    document.body.removeChild(promptModal);
    beforeInstallPromptEvent.prompt();
  });
  promptModal.querySelector('.install-pwa-decline').addEventListener('click', event => {
    document.body.removeChild(promptModal);
  });
  promptModal.querySelector('.install-pwa-dismiss').addEventListener('click', event => {
    document.body.removeChild(promptModal);
  });
  document.body.appendChild(promptModal);
}

if ('serviceWorker' in navigator) {
  window.addEventListener("beforeinstallprompt", async function(beforeInstallPromptEvent) {
    /** event props
     * isTrusted
     * platforms
     * userChoice
     * type
     * target
     * currentTarget
     * eventPhase
     * bubbles
     * cancelable
     * defaultPrevented
     * composed
     * timeStamp
     * srcElement
     * returnValue
     * cancelBubble
     * path
     */
    
    beforeInstallPromptEvent.preventDefault();
    addInstallPWAModal(beforeInstallPromptEvent);
    
    // TODO: Show when the app was installed
    // try {
    //   let userChoice = await beforeInstallPromptEvent.userChoice;
    //   debugger;
    //   console.log(JSON.stringify(userChoice, null, 2));
    // } catch (error) {
    //   console.log(error);
    // }
  });

  navigator.serviceWorker.register('./service-worker.js')
    .catch(error => {
      console.warn(`ServiceWorker registration failed: ${error}`); 
    });
}
