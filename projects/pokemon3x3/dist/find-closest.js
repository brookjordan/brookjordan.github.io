export default function findClosest(selector, element) {
    let elt = element;
    while (elt && elt !== document) {
        if (elt.matches(selector)) {
            return elt;
        }
        elt = elt.parentElement;
    }
}
//# sourceMappingURL=find-closest.js.map