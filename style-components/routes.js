import Router, {
  getRouteFromPath,
  getDataObjectFromPath,
  getCurrentPathString,
} from './router.js';

Router.setOptions({
  method: 'search',
});

Router.root(
  'app-layout',

  route => {
    route.addChildRoute('404', 'not-found-page');

    route.addChildRoute('products', 'products-page');
    route.addChildRoute('product', 'product-page', route => {
      route.addChildRoute('new', 'new-product-page');
      route.addChildRoute(':productID', 'saved-product-page');
      /*
       *
       * This will build DOM that looks something like:
       * <app-layout>
       *   <product-page slot="route">
       *     <saved-product-page productID=[productID] slot="route"></saved-product-page>
       *   </product-page>
       * </app-layout>
       *
       */
    });

    route.addChildRoute('variants', 'variants-page');
    route.addChildRoute('variant/:variantID', 'saved-variant-page');
  },
);


let pathString = getCurrentPathString();
console.log(getRouteFromPath(pathString));
console.log(getDataObjectFromPath(pathString));
