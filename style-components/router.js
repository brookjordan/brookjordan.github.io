import escapeStringAsRegExpLiteral from './utils/reg-exp-escape.js';


const METHODS = [
  'path',
  'search',
];

const routes = [];
const transitions = [];
const options = {
  method: 'path',
};


/*
 * Build a regular expression that can be used as:
 *  - exp.test(pathString) to check if it matches
 *  - exp.exec(pathString) to get data values out
 export */
function buildRouteRegExpIdentifier(route) {
  let identifierParts = route
    .map(part => {
      if (part.startsWith(':')) {
        return '([^/]+)';
      } else {
        return escapeStringAsRegExpLiteral(part);
      }
    });

  return new RegExp(`^/?${identifierParts.join('/')}/?$`);
}

/*
 * Get an array of data keys from the route
 */
export function getRouteDataKeys(route) {
  return route.filter(a => a.startsWith(':')).map(a => a.slice(1))
}

/*
 * Find which route should be used given a path string.
 * May be used on search-type paths:
 *  - getRouteDataKeys(new URLSearchParams(location.search).get('route'))
 * or on normal paths:
 *  - getRouteDataKeys(location.pathname)
 */
export function getRouteFromPath(path) {
  let route = routes.find(route => route.regExpIdentifier.test(path));

  if (route) {
    return route;
  } else {
    console.warn(`The path string "${path}" doesn't match any route definitions.`);
    return routes.find(route => route.regExpIdentifier.test('404')) || routes[0];
  }
}

/*
 * Get an object of dataKeys and values from a path string.
 * May be used on search-type paths:
 *  - getDataObjectFromPath(new URLSearchParams(location.search).get('route'))
 * or on normal paths:
 *  - getDataObjectFromPath(location.pathname)
 */
export function getDataObjectFromPath(path) {
  let route = getRouteFromPath(path);
  if (route.dataKeys.length === 0) {
    return [];
  }

  let { regExpIdentifier, dataKeys } = route;
  let [, ...values] = regExpIdentifier.exec(path) || [];
  return dataKeys.reduce((acc, key, i) => {
    acc[key] = values[i];
    return acc;
  }, {});
}

/*
 * Not using yet

    export function transitionToRoute(route) {
      transitions.forEach(transition => {
        transition();
      });
      // do stuff
    }

    export function addTransitionCallback(transition) {
      transitions.push(transition);
    }

    export function removeTransitionCallback(transition) {
      transitions
        .filter(aTransition => aTransition === transition)
        .forEach(aTransition => { transitions.splice(transitions.indexOf(aTransition), 1); });
    }

 * END Not using yet
 */

function addRoute(
  parentRoute,
  pathStr,
  element,
  callback,
) {
  if (parentRoute == null && routes.length) {
    return new Error('Router error: The root path can only be declared once.');
  }

  let childPath = pathStr ? pathStr.split('/') : [];
  let parentPath = parentRoute && parentRoute.path || [];
  let path = [...parentPath, ...childPath];
  let route = {
    path,
    pathStr,
    element,
    parentRoute,
    regExpIdentifier: buildRouteRegExpIdentifier(path),
    dataKeys: getRouteDataKeys(path),
  };

  routes.push(route);

  if (callback) {
    callback({
      addChildRoute: addRoute.bind(null, route),
    });
  }
}

export function getCurrentPathString() {
  switch (options.method) {
    case 'path':
      return location.pathname;
    case 'search':
        return new URLSearchParams(location.search).get('route');
  }
}


export default {
  root: addRoute.bind(null, null, ''),

  setOptions({ method }) {
    if (METHODS.includes(method)) {
      options.method = method;
    }
  },
};
