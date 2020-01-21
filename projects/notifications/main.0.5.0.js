const CLOSING_MODIFIERS = [
  'hiding',
  'deleting',
];
const savedNotifications = [];
let orderNumber = 1;
let notificationCenterOpen = false;


addNotification();
addNotification();

document.querySelector('.button--delete').addEventListener('click', () => {
  closeFirstNotification('deleting');
});

document.querySelector('.button--add').addEventListener('click', () => {
  clearClosedNotifications();
  addNotification();
});

let notificationButton = document.querySelector('.button--notifications');
let messages = document.querySelector('.messages');
let messagesScroller = document.querySelector('.messages__scroller');
notificationButton.addEventListener('click', async () => {
  if (notificationCenterOpen) {
    closeNotificationsCenter();
  } else {
    openNotificationsCenter();
  }
});
async function openNotificationsCenter() {
  if (
    document.querySelectorAll('.message:not(.message--deleting)').length === 0
    && getValidNotifications().length === 0
  ) { return; }
  await hideAllNotifications();
  savedNotifications.forEach
  messages.classList.add('messages--open');
  notificationCenterOpen = true;
}
function closeNotificationsCenter() {
  messages.classList.remove('messages--open');
  notificationCenterOpen = false;
}

let to;
autoNotifications();
function autoNotifications() {
  let count = document.querySelectorAll('.notification-wrapper').length;

  Math.random() < (0.2 * count - 0.2)
    ? closeFirstNotification('hiding')
    : addNotification();
  to = setTimeout(autoNotifications, Math.random() * 10000 + 5000);
}
document.onvisibilitychange = (e) => {
  if (document.hidden) {
    clearTimeout(to);
  } else {
    autoNotifications();
  }
};



function addNotification() {
  let message = randomPhrase();
  let color =
    `rgb(${
      200 + Math.floor(Math.random() * 56)},${
      200 + Math.floor(Math.random() * 56)},${
      200 + Math.floor(Math.random() * 56)
    })`;

  if (notificationCenterOpen) {
    savedNotifications.push(message);
    sortNotifications();
    addMessage(message, color);
  } else {
let notification = document.createElement('div');
    notification.js_message = message;
    notification.js_color = color;
    clearClosedNotifications();
    notification.className = 'notification-wrapper';
    notification.innerHTML = `
      <div class="
        notification-banner
        notify-banners__notification"
      >
        <div class="notification-banner__info">
          <span>
            ${message}
          </span>
        </div>
        <div class="notification-banner__buttons">
        </div>
      </div>
    `;
    notification.querySelector('.notification-banner').style.backgroundColor = color;

    let buttons = notification.querySelector('.notification-banner__buttons');
    let hideButton = document.createElement('button');
    let closeButton = document.createElement('button');
    hideButton.innerHTML = '<span>Hide</span>';
    closeButton.innerHTML = '<span>Delete</span>';
    hideButton.className = closeButton.className = 'notification-banner__button';

    closeButton.addEventListener('click', () => {
      console.log('click');
      closeNotification('deleting', getValidNotifications().indexOf(notification));
    });
    hideButton.addEventListener('click', () => {
      console.log('click');
      closeNotification('hiding', getValidNotifications().indexOf(notification));
    });

    buttons.appendChild(hideButton);
    buttons.appendChild(closeButton);

    document.querySelector('.notify-banners').appendChild(notification);
  }
}

async function addMessage(txt, color) {
  let messageElt = document.createElement('li');
  let messageWrapperElt = document.createElement('div');
  let deleteElt = document.createElement('button');
  messageElt.className = 'message message--new';
  messageWrapperElt.className = 'message__wrapper';
  messageWrapperElt.style.backgroundColor = color;
  messageWrapperElt.innerHTML = `<p class="message__text">${ txt }</p>`;
  deleteElt.className = 'message__delete';
  deleteElt.innerHTML = '&times;';

  deleteElt.onclick = () => { removeMessage(messageElt); };

  messageWrapperElt.appendChild(deleteElt);
  messageElt.appendChild(messageWrapperElt);
  messagesScroller.insertBefore(messageElt, messagesScroller.firstChild);

  await nextAnimationFrame();
  clearClosedMessages();

  let messageHeight = messageElt.getBoundingClientRect().height;
  let followingMessages = getFollowingElements(messageElt);
  followingMessages.forEach(message => {
    message.style.transition = 'none';
    message.style.transform = `translateY(-${messageHeight}px)`;
  });

  await nextAnimationFrame();

  followingMessages.forEach(message => {
    message.style.transition = null;
    message.style.transform = 'translateY(0)';
  });
}

async function removeMessage(messageElt) {
  await nextAnimationFrame();
  clearClosedMessages();

  let followingMessages = getFollowingElements(messageElt);
  let messageHeight = messageElt.getBoundingClientRect().height;

  messageElt.classList.add('message--deleting');

  if (document.querySelectorAll('.message:not(.message--deleting)').length === 0) {
    closeNotificationsCenter();
  } else {
    followingMessages.forEach(message => {
      message.style.transition = 'none';
      message.style.transform = `translateY(${messageHeight}px)`;
    });

    await nextAnimationFrame();

    followingMessages.forEach(message => {
      message.style.transition = null;
      message.style.transform = 'translateY(0)';
    });
  }
}

function getFollowingElements(elt) {
  let followingElement = elt.nextElementSibling;
  let followingElements = [];
  while (followingElement) {
    followingElements.push(followingElement);
    followingElement = followingElement.nextElementSibling;
  }
  return followingElements;
}

function closeFirstNotification(method = 'hiding') {
  closeNotification(method, 0);
}

async function closeNotification(method = 'hiding', index = 0) {
  await nextAnimationFrame();
  clearClosedNotifications();

  let notification = getNotification(index);
  if (!notification) { return; }
  let followingNotifications = getFollowingNotifications(index);

  let notificationBounds = notification.getBoundingClientRect();
  let notificationButtonBounds = notificationButton.getBoundingClientRect();
  let height = notificationBounds.height;
  getAllNotifications().forEach(notification => {
    notification.style.transform = 'translateY(0)';
    notification.style.transition = 'none';
  });
  followingNotifications.forEach(notification => {
    notification.style.transform = `translateY(${height}px)`;
  });
  notification.style.transform = 'none';
  notification.style.position = 'absolute';
  notification.style.right = '0';

  await nextAnimationFrame();

  followingNotifications.forEach(notification => {
    notification.style.transform = 'translateY(0px)';
    notification.style.transition = null;
  });
  notification.style.transform = null;
  notification.style.transition = null;

  switch(method) {
    case 'hiding':
      let topOffset = (notificationButtonBounds.top + notificationButtonBounds.bottom) / 2 - notificationBounds.top;
      notification.style.transitionDuration = `${(200 - topOffset) / 2000}s`;
      notification.style.transformOrigin = `
        ${(notificationButtonBounds.left + notificationButtonBounds.right) / 2 - notificationBounds.left}px
        ${topOffset}px
      `;
      hideNotification(notification);
      sortNotifications();
      break;

    default:
      notification.classList.add(`notification-wrapper--${ method }`);
      break;
  }
}

async function hideAllNotifications() {
  await nextAnimationFrame();
  clearClosedNotifications();

  let notificationButtonBounds = notificationButton.getBoundingClientRect();

  getAllNotifications().forEach(notification => {
    notification.style.transform = 'translateY(0)';
    notification.style.transition = 'none';
    notification.style.transform = 'none';
  });

  await nextAnimationFrame();

  getAllNotifications().forEach(notification => {
    notification.style.transform = null;
    notification.style.transition = null;

    let notificationBounds = notification.getBoundingClientRect();
    let topOffset = (notificationButtonBounds.top + notificationButtonBounds.bottom) / 2 - notificationBounds.top;
    notification.style.transitionDuration = `${(200 - topOffset) / 2000}s`;
    notification.style.transformOrigin = `
      ${(notificationButtonBounds.left + notificationButtonBounds.right) / 2 - notificationBounds.left}px
      ${topOffset}px
    `;
    hideNotification(notification);
  });
  sortNotifications();
}

function hideNotification(notification) {
  notification.classList.add('notification-wrapper--hiding');
  savedNotifications.push(notification.js_message);
  addMessage(notification.js_message, notification.js_color);
}

function sortNotifications(a,b) {
  return savedNotifications.sort((a,b) => /#(\d+)/.exec(b)[1] - /#(\d+)/.exec(a)[1]);
}

function nextAnimationFrame() {
  return new Promise(res => {
    requestAnimationFrame(res);
  });
}

function clearClosedNotifications() {
  getInvalidNotifications().forEach(elt => elt.parentNode.removeChild(elt));
}

function clearClosedMessages() {
  Array.from(document.querySelectorAll('.message--deleting')).forEach(message => message.parentNode.removeChild(message));
}

function getFirstNotification(notifications) {
  return notifications
    ? notifications[0]
    : document.querySelector('.notification-wrapper');
}

function getNotification(index, notifications) {
  return notifications
    ? notifications[index]
    : document.querySelector(`.notification-wrapper:nth-child(${index + 1})`);
}

function getAllNotifications() {
  return Array.from(document.querySelectorAll('.notification-wrapper'));
}

function getFollowingNotifications(index, notifications) {
  return (notifications || getAllNotifications())
    .filter((notification, i, notifications) => notifications.indexOf(notification) > index);
}

function getValidNotifications(notifications) {
  return notifications
    ? notifications.filter(notification => !CLOSING_MODIFIERS.some(modifier => notification.classList.contains(`.notification-wrapper--${modifier}`)))
    : Array.from(document.querySelectorAll(`.notification-wrapper${CLOSING_MODIFIERS.map(modifier => `:not(.notification-wrapper--${modifier})`).join('')}`));
}

function getInvalidNotifications(notifications) {
  return notifications
    ? notifications.filter(notification => CLOSING_MODIFIERS.some(modifier => notification.classList.contains(`.notification-wrapper--${modifier}`)))
    : Array.from(document.querySelectorAll('.notification-wrapper--hiding,.notification-wrapper--deleting'));
}

function addNumber(strings, no) {
  return (strings[0] + (orderNumber++) + strings[1]).trim().replace(/[\s\n\r\t]+/g, ' ');
}

function randomPhrase() {
  let rnd = Math.random();

  if (rnd < 0.1) {
    return addNumber`You got a new order which is really cool, dude! Oh, it's #${orderNumber}. Go look!`;
  } else if (rnd < 0.2) {
    return addNumber`Go look at order #${orderNumber}.`;
  } else if (rnd < 0.3) {
    return addNumber`
      Oh wow, check this out man! We finally sorted out order #${orderNumber}.
      We've been trying to fix this for years and finally it comes through!
      I TOLD you it wasn't just a waste of time! I TOLD you!
    `;
  } else if (rnd < 0.4) {
    return addNumber`Order #${orderNumber} is done.`;
  } else if (rnd < 0.5) {
    return addNumber`Since when did you get so good at sales? #${orderNumber} was solved!`;
  } else if (rnd < 0.6) {
    return addNumber`#${orderNumber}.`;
  } else if (rnd < 0.7) {
    return addNumber`There has been a problem with #${orderNumber}. Click here to fix it.`;
  } else if (rnd < 0.8) {
    return addNumber`
      CSV #${orderNumber} will finish loading in a few seconds.
      If you close this we'll send you an email to let you know.
      <br>
      <br>
      |=============|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
    `;
  } else if (rnd < 0.9) {
    return addNumber`
      You have #${orderNumber} problems with your WooCommerce store.
      Click here to fix it.
    `;
  } else {
    return addNumber`This is NOT a drill! You sold that orer of drill bits, #${orderNumber}.`;
  }
}
