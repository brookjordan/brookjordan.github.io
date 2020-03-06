"use strict";
fixBase64(window);
globalisePluralise(window);

let getString;
let globalGirls;
let globalBoys;

let main = document.querySelector('main');

class RandomString {
  constructor(words) {
    let o = words || {};
    return () => {
      const addPeople = () => {
        if (gender === "you") {
          phrase += "You";
        } else if (gender === "male") {
          phrase += fillPlaceholders(randomBoy());
        } else if (gender === "female") {
          phrase += fillPlaceholders(randomGirl());
        } else {
          throw new Error("Gender isn't set");
        }

        if ([...boys, ...girls].length >= 2 && Math.random() > 0.92) {
          phrase += `${itemFrom(peopleConnectors, true)} `;
          isPlural = true;

          genderRnd = Math.ceil(
            Math.random() * (girls.length + boys.length)
          );
          if (genderRnd < girls.length) {
            gender = "female";
          } else {
            gender = "male";
          }

          addPeople();
        }
      };

      const addVerbObject = () => {
        const safetyNumber = 3;
        if (
          verbs.length < safetyNumber ||
          boys.length < safetyNumber ||
          girls.length < safetyNumber ||
          sentientObjects.length < safetyNumber ||
          inanimateObjects.length < safetyNumber ||
          pluralisedSentientObjects.length < safetyNumber ||
          pluralisedInanimateObjects.length < safetyNumber
        ) {
          return;
        }

        if (prefixes.length && Math.random() > 0.9) {
          phrase += `${itemFrom(prefixes, false)} `;
        }
        phrase += randomVerb();

        if (
          Math.random() > 0.8 &&
          verbs.length >= safetyNumber &&
          boys.length >= safetyNumber &&
          girls.length >= safetyNumber &&
          sentientObjects.length >= safetyNumber &&
          inanimateObjects.length >= safetyNumber &&
          pluralisedSentientObjects.length >= safetyNumber &&
          pluralisedInanimateObjects.length >= safetyNumber
        ) {
          phrase += itemFrom(phraseConnectors, true);
          addVerbObject();
        }
      };

      const addEnding = () => {
        let chance = new Chance(20);
        if (Math.random() > 0.8) {
          phrase += randomEnding();
        } else {
          let rnd = Math.random() * chance;
          phrase += chance(15)
            ? "."
            : chance(4)
            ? "!"
            : chance(4)
            ? "?"
            : chance(1)
            ? "..."
            : "?!?";
        }
      };

      class Chance {
        constructor(index) {
          let rnd = Math.random() * index;
          let upto = 0;

          return val => {
            upto += val;
            if (upto >= rnd) {
              return true;
            }
            return false;
          };
        }
      }

      const itemFrom = (array, safe) => {
        if (!!safe) {
          return array[Math.floor(Math.random() * array.length)];
        }
        return array.splice(
          Math.floor(Math.random() * array.length),
          1
        )[0];
      };

      const randomAdjective = () => genderise(itemFrom(adjectives, true));
      const randomEnding = () =>
        fillPlaceholders(genderise(itemFrom(endings, true)));

      const randomVerb = () => {
        let verb = itemFrom(verbs, false);
        if (
          places.length &&
          Math.random() > 0.8 &&
          !/\$place/.test(verb)
        ) {
          phrase += randomPlace();
        }
        return subjectise(prefixise(genderise(fillPlaceholders(verb))));
      };

      const randomObject = (options = {}) => {
        let objects = objectSet(options);
        let anObject = itemFrom(objects, false);
        if (!/$thier/.test(anObject)) {
          anObject = anObject.replace(/^[^ ]+ /, "");
        }
        return fillPlaceholders(genderise(anObject));
      };

      const randomObjects = (options = {}) => {
        let words = randomObject(options).split(" ");
        words[words.length - 1] = pluralise(words[words.length - 1]);
        return words.join(" ");
      };

      const randomAnObject = (options = {}) => {
        let objects = objectSet(options);
        return fillPlaceholders(genderise(itemFrom(objects, false)));
      };

      const objectSet = ({
        sentience = "either",
        includePlurals = !usedPluralisedObjects
      } = {}) => {
        let objectSet;
        if (sentience === "sentient") {
          objectSet = includePlurals
            ? randomArray(sentientObjects, pluralisedSentientObjects)
            : sentientObjects;
        } else if (sentience === "inanimate") {
          objectSet = includePlurals
            ? randomArray(inanimateObjects, pluralisedInanimateObjects)
            : inanimateObjects;
        } else {
          objectSet = includePlurals
            ? randomArray(
                sentientObjects,
                inanimateObjects,
                pluralisedSentientObjects,
                pluralisedInanimateObjects
              )
            : randomArray(sentientObjects, inanimateObjects);
        }

        // two sets of pluralised objects rarely works
        if (
          objectSet === pluralisedSentientObjects ||
          objectSet === pluralisedInanimateObjects
        ) {
          usedPluralisedObjects = true;
        }

        return objectSet;
      };

      const randomGirl = () => {
        let girl = genderise(itemFrom(girls, false));
        //if (Math.random() > (isPlural ? 0.8 : 0.5)) { gender = 'female'; }
        return fillPlaceholders(girl);
      };

      const randomBoy = () => {
        let boy = genderise(itemFrom(boys, false));
        //if (Math.random() > (isPlural ? 0.8 : 0.5)) { gender = 'male'; }
        return fillPlaceholders(boy);
      };

      const randomPerson = () => {
        if (Math.random() > 0.5) {
          return randomBoy();
        } else {
          return randomGirl();
        }
      };

      const randomPlace = () =>
        fillPlaceholders(genderise(itemFrom(places, false)));

      const randomSubject = () => {
        let chance = new Chance(2);
        return chance(1) ? randomPerson() : randomAnObject();
      };

      const genderise = string => {
        let genderData = genders[isPlural ? "plural" : gender];
        return string
          .replace("$themself", genderData.themself)
          .replace("$them", genderData.them)
          .replace("$their", genderData.their)
          .replace("$they", genderData.they)
          .replace("$was", genderData.was);
      };

      const prefixise = string =>
        string.replace("$prefix", itemFrom(prefixes, false));
      const subjectise = string =>
        string.replace("$subject", randomSubject());

      const fillPlaceholders = string => {
        string = fillPlaceholder(string, "$subject", randomSubject);
        string = fillPlaceholder(string, "$girl", randomGirl);
        string = fillPlaceholder(string, "$boy", randomBoy);
        string = fillPlaceholder(string, "$person", randomPerson);

        string = fillPlaceholder(string, "$objects", () =>
          randomObjects({ includePlurals: false })
        );
        string = fillPlaceholder(string, "$sentientObjects", () =>
          randomObjects({ sentience: "sentient", includePlurals: false })
        );
        string = fillPlaceholder(string, "$inanimateObjects", () =>
          randomObjects({ sentience: "inanimate", includePlurals: false })
        );

        string = fillPlaceholder(string, "$anObject", randomAnObject);
        string = fillPlaceholder(string, "$aSentientObject", () =>
          randomAnObject({ sentience: "sentient" })
        );
        string = fillPlaceholder(string, "$anInanimateObject", () =>
          randomAnObject({ sentience: "inanimate" })
        );

        string = fillPlaceholder(string, "$object", randomObject);
        string = fillPlaceholder(string, "$sentientObject", () =>
          randomObject({ sentience: "sentient" })
        );
        string = fillPlaceholder(string, "$inanimateObject", () =>
          randomObject({ sentience: "inanimate" })
        );

        string = fillPlaceholder(string, "$adj", randomAdjective);
        string = fillPlaceholder(string, "$didSomething", randomVerb);
        string = fillPlaceholder(string, "$place", randomPlace);

        return string;
      };

      const fillPlaceholder = (string, placeholder, randomPhrase) => {
        while (string.indexOf(placeholder) > -1) {
          string = string.replace(placeholder, randomPhrase());
          fillPlaceholder(string, placeholder, randomPhrase);
        }
        return string;
      };

      const buildPhraseConnectors = () => {
        phraseConnectors = [
          " and",
          " then",
          genderise(" as $they"),
          genderise(" before $they"),
          genderise(" when $they"),
          genderise(" after $they"),
          genderise(" because $they"),
          genderise(" but then $they")
        ];
      };

      const cleanPhrase = phrase =>
        phrase.replace(/,{2}/, ",").replace(/s's/g, "s'");

      const randomArray = (...arrs) => {
        let length = [].concat(...arrs).length;
        let rnd = Math.random();
        let cul = 0;
        for (let i = 0; i < arrs.length; i += 1) {
          if (arrs[i].length === 0) {
            continue;
          }
          cul += arrs[i].length;
          if (i === arrs.length - 1 || rnd >= cul / length) {
            return arrs[i];
          }
        }
      };

      let usedPluralisedObjects = false;
      let girls = globalGirls.slice(0);
      let boys = globalBoys.slice(0);
      let prefixes = o.prefixes
        ? o.prefixes.slice(0)
        : "gladly | slowly".split(" | ");
      let verbs = o.verbs
        ? o.verbs.slice(0)
        : "likes $anObject | $was happy".split(" | ");
      let inanimateObjects = o.inanimateObjects.slice(0);
      let sentientObjects = o.sentientObjects
        ? o.sentientObjects.slice(0)
        : "$themself | a turtle".split(" | ");
      let pluralisedInanimateObjects = o.pluralisedInanimateObjects
        ? o.pluralisedInanimateObjects.slice(0)
        : "some $inanimateObjects | a few $inanimateObjects".split(" | ");
      let pluralisedSentientObjects = o.pluralisedSentientObjects
        ? o.pluralisedSentientObjects.slice(0)
        : "some $sentientObjects | a few $sentientObjects".split(" | ");
      let places = o.places
        ? o.places.slice(0)
        : "in the park | with $their friends".split(" | ");
      let adjectives = o.adjectives
        ? o.adjectives.slice(0)
        : "a small | an enormous".split(" | ");
      let endings = o.endings
        ? o.endings.slice(0)
        : " yesterday. |  with high spirits!".split(" | ");
      let genders = {
        you: {
          they: "you",
          their: "your",
          them: "you",
          themself: "yourself",
          was: "were"
        },
        male: {
          they: "he",
          their: "his",
          them: "him",
          themself: "himself",
          was: "was"
        },
        female: {
          they: "she",
          their: "her",
          them: "her",
          themself: "herself",
          was: "was"
        },
        plural: {
          they: "they",
          their: "their",
          them: "them",
          themself: "themselves",
          was: "were"
        }
      };
      let genderRnd = Math.ceil(
        Math.random() * (girls.length + boys.length + 1)
      );
      let gender;
      let isPlural;
      if (genderRnd === 1) {
        gender = "you";
      } else if (genderRnd <= girls.length + 1) {
        gender = "female";
      } else {
        gender = "male";
      }
      let peopleConnectors = [" and", ", then"];
      let phraseConnectors = undefined;
      let phrase = "";
      addPeople();
      girls = girls.concat(o.extraGirls || []);
      boys = boys.concat(o.extraBoys || []);
      buildPhraseConnectors();
      addVerbObject();
      addEnding();
      let cleanedPhrase = cleanPhrase(phrase);

      return cleanedPhrase;
    };
  }
}

const _begin = words => {
  getString = new RandomString(words);
  buildWordsIfSpaceIsAvailable();
  window.onscroll = window.ontouchmove = window.onresize = buildWordsIfSpaceIsAvailable;
};

const buildWordsIfSpaceIsAvailable = () => {
  if (
    !building &&
    window.scrollY + innerHeight * 2.5 >=
      document.body.getBoundingClientRect().height
  ) {
    buildWords();
  }
};

const buildWords = () => {
  building = true;
  requestAnimationFrame(() => {
    building = false;
    try {
      buildWord(getString(), true);
    } catch (e) {
      console.warn(`Something broke: "${e}"`);
    }
    buildWordsIfSpaceIsAvailable();
  });
};
const buildWord = (str, active) => {
  let div = document.createElement("div");
  let a = document.createElement("a");
  if (!!active) {
    try {
      a.href = `?_=${encodeURIComponent(btoaUTF8(str))}`;
      //a.target = "_blank";
    } catch (e) {
      console.warn(`Link could not be created for: "${str}"\n${e}`);
    }
    div.style = makeStyle(str);
  } else {
    a.href = "?";
    a.target = "_self";
  }

  if (
    navigator.canShare
      ? navigator.canShare()
      : "share" in window.navigator
  ) {
    let shareButton = document.createElement('button');
    shareButton.classList.add("share-button");
    shareButton.innerText = "Share";
    div.appendChild(shareButton);
    shareButton.addEventListener('click', event => {
      event.preventDefault();
        window.navigator.share({
          url: location.href,
          text: str,
          title: "You won't believe this…",
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          console.log(error);
        });
    });
  }

  a.innerHTML = str;
  div.className = "post-it closed";
  div.appendChild(a);

  requestAnimationFrame(() => {
    main.appendChild(div);
    requestAnimationFrame(() => {
      div.classList.remove("closed");
    });
  });
  document.title = str;
};

const makeStyle = str => `font-size:${Math.max(16, len(str.length))}px`;

const len = x => {
  let min = 14;
  let max = 26;
  return max - Math.max(0, Math.min(max - min, 15 - 1000 / x));
};

//https://developer.mozilla.org/en-US/docs/Web/API/WindowBase64/Base64_encoding_and_decoding#The_Unicode_Problem
// prettier-ignore
function fixBase64(e){function h(b){let a=b.charCodeAt(0);if(55296<=a&&56319>=a)if(b=b.charCodeAt(1),b===b&&56320<=b&&57343>=b){if(a=1024*(a-55296)+b-56320+65536,65535<a)return d(240|a>>>18,128|a>>>12&63,128|a>>>6&63,128|a&63)}else return d(239,191,189);return 127>=a?inputString:2047>=a?d(192|a>>>6,128|a&63):d(224|a>>>12,128|a>>>6&63,128|a&63)}function k(b){let a=b.charCodeAt(0)<<24,f=l(~a),c=0,e=b.length,g="";if(5>f&&e>=f){a=a<<f>>>24+f;for(c=1;c<f;++c)a=a<<6|b.charCodeAt(c)&63;65535>=a?g+=d(a):1114111>=
  a?(a-=65536,g+=d((a>>10)+55296,(a&1023)+56320)):c=0}for(;c<e;++c)g+="\ufffd";return g}let m=Math.log,n=Math.LN2,l=Math.clz32||function(b){return 31-m(b>>>0)/n|0},d=String.fromCharCode,p=atob,q=btoa;e.btoaUTF8=function(b,a){return q((a?"\u00ef\u00bb\u00bf":"")+b.replace(/[\x80-\uD7ff\uDC00-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]?/g,h))};e.atobUTF8=function(b,a){a||"\u00ef\u00bb\u00bf"!==b.substring(0,3)||(b=b.substring(3));return p(b).replace(/[\xc0-\xff][\x80-\xbf]*/g,k)}}

//https://github.com/didanurwanda/inflector-js
// prettier-ignore
function globalisePluralise(d){
  let unPluralisableWords = 'equipment information rice money species series fish sheep moose deer news fat oxygen poop water soap';
  let f=unPluralisableWords.split(" "),c=[[RegExp("(m)an$","gi"),"$1en"],[RegExp("(pe)rson$","gi"),"$1ople"],[RegExp("(child)$","gi"),"$1ren"],[RegExp("^(ox)$","gi"),"$1en"],[RegExp("(ax|test)is$","gi"),"$1es"],[RegExp("(octop|vir)us$","gi"),"$1i"],[RegExp("(alias|status)$","gi"),"$1es"],[RegExp("(bu)s$","gi"),"$1ses"],[RegExp("(buffal|tomat|potat)o$","gi"),"$1oes"],[RegExp("([ti])um$","gi"),"$1a"],[RegExp("sis$","gi"),"ses"],[RegExp("(?:([^f])fe|([lr])f)$",
  "gi"),"$1$2ves"],[RegExp("(hive)$","gi"),"$1s"],[RegExp("([^aeiouy]|qu)y$","gi"),"$1ies"],[RegExp("(x|ch|ss|sh)$","gi"),"$1es"],[RegExp("(matr|vert|ind)ix|ex$","gi"),"$1ices"],[RegExp("([m|l])ouse$","gi"),"$1ice"],[RegExp("(quiz)$","gi"),"$1zes"],[RegExp("s$","gi"),"s"],[RegExp("$","gi"),"s"]];d.pluralise=function(d,e){let a=d;if(e)a=e;else if(!(-1<f.indexOf(a.toLowerCase())))for(let b=0;b<c.length;b++)if(a.match(c[b][0])){a=a.replace(c[b][0],c[b][1]);break}return a}}

let begin = _ => _;
let building = false;

if (searchParams["_"]) {
  document.body.className = "only";
  buildWord(atobUTF8(searchParams._), false);
} else {
  begin = _begin;
}

const setDefaultGlobalNames = () => {
  if (typeof globalGirls === 'undefined' && searchParams.girls && (!localStorage.getItem("girls") || confirm(`Replace saved girls with ${searchParams.girls}?`))) {
    globalGirls = searchParams.girls.split(",");
  }  else if (!globalGirls && localStorage.getItem("girls")) {
    globalGirls = localStorage.getItem("girls").split(",");
  } else if (typeof defaultGirls !== "undefined") {
    globalGirls = defaultGirls;
  } else {
    globalGirls = "Mary | Sue".split(" | ");
  }
  localStorage.setItem("girls", globalGirls);

  if (typeof globalBoys === 'undefined' && searchParams.boys && (!localStorage.getItem("boys") || confirm(`Replace saved boys with ${searchParams.boys}?`))) {
    globalBoys = searchParams.boys.split(",");
  }  else if (!globalBoys && localStorage.getItem("boys")) {
    globalBoys = localStorage.getItem("boys").split(",");
  } else if (typeof defaultGirls !== "undefined") {
    globalBoys = defaultBoys;
  } else {
    globalBoys = "Fred | Dave".split(" | ");
  }
  localStorage.setItem("boys", globalBoys);
};
setDefaultGlobalNames();
history.replaceState({}, '', `${location.pathname}${searchParams["_"] ? `?_=${searchParams["_"]}` : ''}`);

begin({
  extraGirls: defaultExtraGirls,
  extraBoys: defaultExtraBoys,
  prefixes: defaultPrefixes,
  verbs: defaultVerbs,

  sentientObjects: defaultSentientObjects,
  inanimateObjects: defaultInanimateObjects,

  pluralisedSentientObjects: defaultPluralisedSentientObjects,
  pluralisedInanimateObjects: defaultPluralisedInanimateObjects,

  places: defaultPlaces,
  adjectives: defaultAdjectives,
  endings: defaultEndings
});
