let l;
let i;
export default function shuffle(array) {
    l = array.length;
    while (l) {
        i = Math.floor(Math.random() * l--);
        [array[i], array[l]] = [array[l], array[i]];
    }
    return array;
}
//# sourceMappingURL=shuffle-array.js.map