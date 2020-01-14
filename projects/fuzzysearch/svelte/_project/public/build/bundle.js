
(function(l, r) { if (l.getElementById('livereloadscript')) return; r = l.createElement('script'); r.async = 1; r.src = '//' + (window.location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1'; r.id = 'livereloadscript'; l.head.appendChild(r) })(window.document);
var app = (function () {
    'use strict';

    function noop() { }
    function add_location(element, file, line, column, char) {
        element.__svelte_meta = {
            loc: { file, line, column, char }
        };
    }
    function run(fn) {
        return fn();
    }
    function blank_object() {
        return Object.create(null);
    }
    function run_all(fns) {
        fns.forEach(run);
    }
    function is_function(thing) {
        return typeof thing === 'function';
    }
    function safe_not_equal(a, b) {
        return a != a ? b == b : a !== b || ((a && typeof a === 'object') || typeof a === 'function');
    }

    function append(target, node) {
        target.appendChild(node);
    }
    function insert(target, node, anchor) {
        target.insertBefore(node, anchor || null);
    }
    function detach(node) {
        node.parentNode.removeChild(node);
    }
    function destroy_each(iterations, detaching) {
        for (let i = 0; i < iterations.length; i += 1) {
            if (iterations[i])
                iterations[i].d(detaching);
        }
    }
    function element(name) {
        return document.createElement(name);
    }
    function text(data) {
        return document.createTextNode(data);
    }
    function space() {
        return text(' ');
    }
    function empty() {
        return text('');
    }
    function listen(node, event, handler, options) {
        node.addEventListener(event, handler, options);
        return () => node.removeEventListener(event, handler, options);
    }
    function attr(node, attribute, value) {
        if (value == null)
            node.removeAttribute(attribute);
        else if (node.getAttribute(attribute) !== value)
            node.setAttribute(attribute, value);
    }
    function children(element) {
        return Array.from(element.childNodes);
    }
    function set_input_value(input, value) {
        if (value != null || input.value) {
            input.value = value;
        }
    }
    function custom_event(type, detail) {
        const e = document.createEvent('CustomEvent');
        e.initCustomEvent(type, false, false, detail);
        return e;
    }

    let current_component;
    function set_current_component(component) {
        current_component = component;
    }
    function get_current_component() {
        if (!current_component)
            throw new Error(`Function called outside component initialization`);
        return current_component;
    }
    function onMount(fn) {
        get_current_component().$$.on_mount.push(fn);
    }

    const dirty_components = [];
    const binding_callbacks = [];
    const render_callbacks = [];
    const flush_callbacks = [];
    const resolved_promise = Promise.resolve();
    let update_scheduled = false;
    function schedule_update() {
        if (!update_scheduled) {
            update_scheduled = true;
            resolved_promise.then(flush);
        }
    }
    function add_render_callback(fn) {
        render_callbacks.push(fn);
    }
    function flush() {
        const seen_callbacks = new Set();
        do {
            // first, call beforeUpdate functions
            // and update components
            while (dirty_components.length) {
                const component = dirty_components.shift();
                set_current_component(component);
                update(component.$$);
            }
            while (binding_callbacks.length)
                binding_callbacks.pop()();
            // then, once components are updated, call
            // afterUpdate functions. This may cause
            // subsequent updates...
            for (let i = 0; i < render_callbacks.length; i += 1) {
                const callback = render_callbacks[i];
                if (!seen_callbacks.has(callback)) {
                    callback();
                    // ...so guard against infinite loops
                    seen_callbacks.add(callback);
                }
            }
            render_callbacks.length = 0;
        } while (dirty_components.length);
        while (flush_callbacks.length) {
            flush_callbacks.pop()();
        }
        update_scheduled = false;
    }
    function update($$) {
        if ($$.fragment !== null) {
            $$.update();
            run_all($$.before_update);
            const dirty = $$.dirty;
            $$.dirty = [-1];
            $$.fragment && $$.fragment.p($$.ctx, dirty);
            $$.after_update.forEach(add_render_callback);
        }
    }
    const outroing = new Set();
    function transition_in(block, local) {
        if (block && block.i) {
            outroing.delete(block);
            block.i(local);
        }
    }

    const globals = (typeof window !== 'undefined' ? window : global);
    function mount_component(component, target, anchor) {
        const { fragment, on_mount, on_destroy, after_update } = component.$$;
        fragment && fragment.m(target, anchor);
        // onMount happens before the initial afterUpdate
        add_render_callback(() => {
            const new_on_destroy = on_mount.map(run).filter(is_function);
            if (on_destroy) {
                on_destroy.push(...new_on_destroy);
            }
            else {
                // Edge case - component was destroyed immediately,
                // most likely as a result of a binding initialising
                run_all(new_on_destroy);
            }
            component.$$.on_mount = [];
        });
        after_update.forEach(add_render_callback);
    }
    function destroy_component(component, detaching) {
        const $$ = component.$$;
        if ($$.fragment !== null) {
            run_all($$.on_destroy);
            $$.fragment && $$.fragment.d(detaching);
            // TODO null out other refs, including component.$$ (but need to
            // preserve final state?)
            $$.on_destroy = $$.fragment = null;
            $$.ctx = [];
        }
    }
    function make_dirty(component, i) {
        if (component.$$.dirty[0] === -1) {
            dirty_components.push(component);
            schedule_update();
            component.$$.dirty.fill(0);
        }
        component.$$.dirty[(i / 31) | 0] |= (1 << (i % 31));
    }
    function init(component, options, instance, create_fragment, not_equal, props, dirty = [-1]) {
        const parent_component = current_component;
        set_current_component(component);
        const prop_values = options.props || {};
        const $$ = component.$$ = {
            fragment: null,
            ctx: null,
            // state
            props,
            update: noop,
            not_equal,
            bound: blank_object(),
            // lifecycle
            on_mount: [],
            on_destroy: [],
            before_update: [],
            after_update: [],
            context: new Map(parent_component ? parent_component.$$.context : []),
            // everything else
            callbacks: blank_object(),
            dirty
        };
        let ready = false;
        $$.ctx = instance
            ? instance(component, prop_values, (i, ret, ...rest) => {
                const value = rest.length ? rest[0] : ret;
                if ($$.ctx && not_equal($$.ctx[i], $$.ctx[i] = value)) {
                    if ($$.bound[i])
                        $$.bound[i](value);
                    if (ready)
                        make_dirty(component, i);
                }
                return ret;
            })
            : [];
        $$.update();
        ready = true;
        run_all($$.before_update);
        // `false` as a special case of no DOM component
        $$.fragment = create_fragment ? create_fragment($$.ctx) : false;
        if (options.target) {
            if (options.hydrate) {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                $$.fragment && $$.fragment.l(children(options.target));
            }
            else {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                $$.fragment && $$.fragment.c();
            }
            if (options.intro)
                transition_in(component.$$.fragment);
            mount_component(component, options.target, options.anchor);
            flush();
        }
        set_current_component(parent_component);
    }
    class SvelteComponent {
        $destroy() {
            destroy_component(this, 1);
            this.$destroy = noop;
        }
        $on(type, callback) {
            const callbacks = (this.$$.callbacks[type] || (this.$$.callbacks[type] = []));
            callbacks.push(callback);
            return () => {
                const index = callbacks.indexOf(callback);
                if (index !== -1)
                    callbacks.splice(index, 1);
            };
        }
        $set() {
            // overridden by instance, if it has props
        }
    }

    function dispatch_dev(type, detail) {
        document.dispatchEvent(custom_event(type, Object.assign({ version: '3.17.0' }, detail)));
    }
    function append_dev(target, node) {
        dispatch_dev("SvelteDOMInsert", { target, node });
        append(target, node);
    }
    function insert_dev(target, node, anchor) {
        dispatch_dev("SvelteDOMInsert", { target, node, anchor });
        insert(target, node, anchor);
    }
    function detach_dev(node) {
        dispatch_dev("SvelteDOMRemove", { node });
        detach(node);
    }
    function listen_dev(node, event, handler, options, has_prevent_default, has_stop_propagation) {
        const modifiers = options === true ? ["capture"] : options ? Array.from(Object.keys(options)) : [];
        if (has_prevent_default)
            modifiers.push('preventDefault');
        if (has_stop_propagation)
            modifiers.push('stopPropagation');
        dispatch_dev("SvelteDOMAddEventListener", { node, event, handler, modifiers });
        const dispose = listen(node, event, handler, options);
        return () => {
            dispatch_dev("SvelteDOMRemoveEventListener", { node, event, handler, modifiers });
            dispose();
        };
    }
    function attr_dev(node, attribute, value) {
        attr(node, attribute, value);
        if (value == null)
            dispatch_dev("SvelteDOMRemoveAttribute", { node, attribute });
        else
            dispatch_dev("SvelteDOMSetAttribute", { node, attribute, value });
    }
    function set_data_dev(text, data) {
        data = '' + data;
        if (text.data === data)
            return;
        dispatch_dev("SvelteDOMSetData", { node: text, data });
        text.data = data;
    }
    class SvelteComponentDev extends SvelteComponent {
        constructor(options) {
            if (!options || (!options.target && !options.$$inline)) {
                throw new Error(`'target' is a required option`);
            }
            super();
        }
        $destroy() {
            super.$destroy();
            this.$destroy = () => {
                console.warn(`Component was already destroyed`); // eslint-disable-line no-console
            };
        }
    }

    function sortByScore(a, b) {
    	if (a.score === b.score) {
    		return a.string.localeCompare(b.string);
    	} else {
    		return b.score - a.score;
    	}
    }

    function getWordData(searchTerm, string) {
    	let parts = [];
    	let broken = "";
    	let finding = "";
    	let spare = "";
    	let matchLength = 0;
    	let baseScore = 0;
    	let multiplier = 1;

    	string.split("").forEach((character, i) => {
    		//  If we’re at a space, try to do as little as possible
    		if (/\s/.test(character)) {
    			if (finding.length) {
    				//  Prevent words with trailing spaces
    				spare += character;
    			} else {
    				broken += character;
    			}
    		}

    		//  If we’re matching, add to the matching score
    		else if (character.toLowerCase() === searchTerm[matchLength]) {
    			if (broken.length) {
    				parts.push({
    					isUsed: false,
    					value: broken
    				});
    			}

    			broken = "";
    			if (i === 0) {
    				multiplier += 4;
    			} else {
    				multiplier += 2 / i;
    			}

    			finding += `${spare}${character}`;
    			spare = "";

    			do {
    				++matchLength;
    			} while (/\s/.test(searchTerm[matchLength]))
    		}

    		//  Otherwise store then kill the current match we’re building
    		else {
    			if (finding.length) {
    				parts.push({
    					isUsed: true,
    					value: finding,
    				});
    				finding = "";
    			}

    			broken += `${spare}${character}`;
    			spare = "";
    		}
    	});

    	//  Clean up loose ends
    	if (finding.length) {
    		parts.push({
    			isUsed: true,
    			value: finding,
    		});
    	}
    	if (broken.length) {
    		parts.push({
    			isUsed: false,
    			value: broken,
    		});
    	}

    	if (!searchTerm.length || parts.length && matchLength) {
    		let formatted;
    		formatted = parts
    			.map((part) => {
    				if (part.isUsed) {
    					baseScore += 3 ** part.value.replace(/\s/g, "").length;
    					return `<strong>${part.value}</strong>`;
    				} else {
    					return part.value;
    				}
    			})
    			.join("");

    		return {
    			parts,
    			string,
    			baseScore,
    			formatted,
    			searchTerm,
    			score: baseScore * multiplier,
    			isFullMatch: matchLength === searchTerm.length,
    		};
    	}
    }

    function getFuzzyMatchArray(searchTerm, wordsList, sort) {
    	let lowerCasedSearchTerm = searchTerm.toLowerCase();
    	let matches = wordsList
    		.map(word => getWordData(lowerCasedSearchTerm, word))
    		.filter(_ => !!_);

    	if (!!sort) {
    		matches.sort(sortByScore);
    	}

    	return matches;
    }

    const allPokemonNames = Object.freeze([
      "Abomasnow: Mega",
      "Abomasnow",
      "Abra",
      "Absol: Mega",
      "Absol",
      "Accelgor",
      "Aegislash: Blade",
      "Aegislash: Shield",
      "Aerodactyl: Mega",
      "Aerodactyl",
      "Aggron: Mega",
      "Aggron",
      "Aipom",
      "Alakazam: Mega",
      "Alakazam",
      "Alomomola",
      "Altaria: Mega",
      "Altaria",
      "Amaura",
      "Ambipom",
      "Amoonguss",
      "Ampharos: Mega",
      "Ampharos",
      "Anorith",
      "Araquanid",
      "Arbok",
      "Arcanine",
      "Arceus",
      "Archen",
      "Archeops",
      "Ariados",
      "Armaldo",
      "Aromatisse",
      "Aron",
      "Articuno",
      "Audino: Mega",
      "Audino",
      "Aurorus",
      "Avalugg",
      "Axew",
      "Azelf",
      "Azumarill",
      "Azurill",
      "Bagon",
      "Baltoy",
      "Banette: Mega",
      "Banette",
      "Barbaracle",
      "Barboach",
      "Basculin: Blue striped",
      "Basculin: Red striped",
      "Bastiodon",
      "Bayleef",
      "Beartic",
      "Beautifly",
      "Beedrill: Mega",
      "Beedrill",
      "Beheeyem",
      "Beldum",
      "Bellossom",
      "Bellsprout",
      "Bergmite",
      "Bewear",
      "Bibarel",
      "Bidoof",
      "Binacle",
      "Bisharp",
      "Blastoise: Mega",
      "Blastoise",
      "Blaziken: Mega",
      "Blaziken",
      "Blissey",
      "Blitzle",
      "Boldore",
      "Bonsly",
      "Bouffalant",
      "Bounsweet",
      "Braixen",
      "Braviary",
      "Breloom",
      "Brionne",
      "Bronzong",
      "Bronzor",
      "Bruxish",
      "Budew",
      "Buizel",
      "Bulbasaur",
      "Buneary",
      "Bunnelby",
      "Burmy",
      "Butterfree",
      "Buzzwole",
      "Cacnea",
      "Cacturne",
      "Camerupt: Mega",
      "Camerupt",
      "Carbink",
      "Carnivine",
      "Carracosta",
      "Carvanha",
      "Cascoon",
      "Castform: Rainy",
      "Castform: Snowy",
      "Castform: Sunny",
      "Castform",
      "Caterpie",
      "Celebi",
      "Celesteela",
      "Chandelure",
      "Chansey",
      "Charizard: Mega x",
      "Charizard: Mega y",
      "Charizard",
      "Charjabug",
      "Charmander",
      "Charmeleon",
      "Chatot",
      "Cherrim",
      "Cherubi",
      "Chesnaught",
      "Chespin",
      "Chikorita",
      "Chimchar",
      "Chimecho",
      "Chinchou",
      "Chingling",
      "Cinccino",
      "Clamperl",
      "Clauncher",
      "Clawitzer",
      "Claydol",
      "Clefable",
      "Clefairy",
      "Cleffa",
      "Cloyster",
      "Cobalion",
      "Cofagrigus",
      "Combee",
      "Combusken",
      "Comfey",
      "Conkeldurr",
      "Corphish",
      "Corsola",
      "Cosmoem",
      "Cosmog",
      "Cottonee",
      "Crabominable",
      "Crabrawler",
      "Cradily",
      "Cranidos",
      "Crawdaunt",
      "Cresselia",
      "Croagunk",
      "Crobat",
      "Croconaw",
      "Crustle",
      "Cryogonal",
      "Cubchoo",
      "Cubone",
      "Cutiefly",
      "Cyndaquil",
      "Darkrai",
      "Darmanitan",
      "Darmanitan: Zen",
      "Dartrix",
      "Darumaka",
      "Decidueye",
      "Dedenne",
      "Deerling",
      "Deino",
      "Delcatty",
      "Delibird",
      "Delphox",
      "Deoxys",
      "Deoxys: Attack",
      "Deoxys: Defense",
      "Deoxys: Speed",
      "Dewgong",
      "Dewott",
      "Dewpider",
      "Dhelmise",
      "Dialga",
      "Diancie: Mega",
      "Diancie",
      "Diggersby",
      "Diglett",
      "Ditto",
      "Dodrio",
      "Doduo",
      "Donphan",
      "Doublade",
      "Dragalge",
      "Dragonair",
      "Dragonite",
      "Drampa",
      "Drapion",
      "Dratini",
      "Drifblim",
      "Drifloon",
      "Drilbur",
      "Drowzee",
      "Druddigon",
      "Ducklett",
      "Dugtrio",
      "Dunsparce",
      "Duosion",
      "Durant",
      "Dusclops",
      "Dusknoir",
      "Duskull",
      "Dustox",
      "Dwebble",
      "Eelektrik",
      "Eelektross",
      "Eevee",
      "Ekans",
      "Electabuzz",
      "Electivire",
      "Electrike",
      "Electrode",
      "Elekid",
      "Elgyem",
      "Emboar",
      "Emolga",
      "Empoleon",
      "Entei",
      "Escavalier",
      "Espeon",
      "Espurr",
      "Excadrill",
      "Exeggcute",
      "Exeggutor",
      "Exploud",
      "Farfetchd",
      "Fearow",
      "Feebas",
      "Fennekin",
      "Feraligatr",
      "Ferroseed",
      "Ferrothorn",
      "Finneon",
      "Flaaffy",
      "Flabebe",
      "Flareon",
      "Fletchinder",
      "Fletchling",
      "Floatzel",
      "Floette",
      "Floette: Eternal",
      "Florges",
      "Flygon",
      "Fomantis",
      "Foongus",
      "Forretress",
      "Fraxure",
      "Frillish",
      "Froakie",
      "Frogadier",
      "Froslass",
      "Furfrou",
      "Furret",
      "Gabite",
      "Gallade: Mega",
      "Gallade",
      "Galvantula",
      "Garbodor",
      "Garchomp: Mega",
      "Garchomp",
      "Gardevoir: Mega",
      "Gardevoir",
      "Gastly",
      "Gastrodon",
      "Genesect",
      "Gengar: Mega",
      "Gengar",
      "Geodude",
      "Gible",
      "Gigalith",
      "Girafarig",
      "Giratina",
      "Giratina: Altered",
      "Glaceon",
      "Glalie: Mega",
      "Glalie",
      "Glameow",
      "Gligar",
      "Gliscor",
      "Gloom",
      "Gogoat",
      "Golbat",
      "Goldeen",
      "Golduck",
      "Golem",
      "Golett",
      "Golisopod",
      "Golurk",
      "Goodra",
      "Goomy",
      "Gorebyss",
      "Gothita",
      "Gothitelle",
      "Gothorita",
      "Gourgeist",
      "Gourgeist: Large",
      "Gourgeist: Small",
      "Gourgeist: Super",
      "Granbull",
      "Graveler",
      "Greninja",
      "Grimer",
      "Grotle",
      "Groudon: Primal",
      "Groudon",
      "Grovyle",
      "Growlithe",
      "Grubbin",
      "Grumpig",
      "Gulpin",
      "Gumshoos",
      "Gurdurr",
      "Guzzlord",
      "Gyarados: Mega",
      "Gyarados",
      "Hakamo: O",
      "Happiny",
      "Hariyama",
      "Haunter",
      "Hawlucha",
      "Haxorus",
      "Heatmor",
      "Heatran",
      "Heliolisk",
      "Helioptile",
      "Heracross: Mega",
      "Heracross",
      "Herdier",
      "Hippopotas",
      "Hippowdon",
      "Hitmonchan",
      "Hitmonlee",
      "Hitmontop",
      "Ho-oh",
      "Honchkrow",
      "Honedge",
      "Hoopa: Unbound",
      "Hoopa",
      "Hoothoot",
      "Hoppip",
      "Horsea",
      "Houndoom: Mega",
      "Houndoom",
      "Houndour",
      "Huntail",
      "Hydreigon",
      "Hypno",
      "Igglybuff",
      "Illumise",
      "Incineroar",
      "Infernape",
      "Inkay",
      "Ivysaur",
      "Jangmo-o",
      "Jellicent",
      "Jigglypuff",
      "Jirachi",
      "Jolteon",
      "Joltik",
      "Jumpluff",
      "Jynx",
      "Kabuto",
      "Kabutops",
      "Kadabra",
      "Kakuna",
      "Kangaskhan: Mega",
      "Kangaskhan",
      "Karrablast",
      "Kartana",
      "Kecleon",
      "Keldeo",
      "Keldeo: Resolute",
      "Kingdra",
      "Kingler",
      "Kirlia",
      "Klang",
      "Klefki",
      "Klink",
      "Klinklang",
      "Koffing",
      "Komala",
      "Kommo-o",
      "Krabby",
      "Kricketot",
      "Kricketune",
      "Krokorok",
      "Krookodile",
      "Kyogre: Primal",
      "Kyogre",
      "Kyurem: Black",
      "Kyurem: White",
      "Kyurem",
      "Lairon",
      "Lampent",
      "Landorus: Incarnate",
      "Landorus: Therian",
      "Lanturn",
      "Lapras",
      "Larvesta",
      "Larvitar",
      "Latias: Mega",
      "Latias",
      "Latios: Mega",
      "Latios",
      "Leafeon",
      "Leavanny",
      "Ledian",
      "Ledyba",
      "Lickilicky",
      "Lickitung",
      "Liepard",
      "Lileep",
      "Lilligant",
      "Lillipup",
      "Linoone",
      "Litleo",
      "Litten",
      "Litwick",
      "Lombre",
      "Lopunny: Mega",
      "Lopunny",
      "Lotad",
      "Loudred",
      "Lucario: Mega",
      "Lucario",
      "Ludicolo",
      "Lugia",
      "Lumineon",
      "Lunala",
      "Lunatone",
      "Lurantis",
      "Luvdisc",
      "Luxio",
      "Luxray",
      "Lycanroc midday",
      "Machamp",
      "Machoke",
      "Machop",
      "Magby",
      "Magcargo",
      "Magearna",
      "Magikarp",
      "Magmar",
      "Magmortar",
      "Magnemite",
      "Magneton",
      "Magnezone",
      "Makuhita",
      "Malamar",
      "Mamoswine",
      "Manaphy",
      "Mandibuzz",
      "Manectric: Mega",
      "Manectric",
      "Mankey",
      "Mantine",
      "Mantyke",
      "Maractus",
      "Mareanie",
      "Mareep",
      "Marill",
      "Marowak",
      "Marshadow",
      "Marshtomp",
      "Masquerain",
      "Mawile: Mega",
      "Mawile",
      "Medicham: Mega",
      "Medicham",
      "Meditite",
      "Meganium",
      "Meloetta: Aria",
      "Meloetta: Pirouette",
      "Meowstic: Male",
      "Meowstic: Female",
      "Meowth",
      "Mesprit",
      "Metagross: Mega",
      "Metagross",
      "Metang",
      "Metapod",
      "Mew",
      "Mewtwo: Mega x",
      "Mewtwo: Mega y",
      "Mewtwo",
      "Mienfoo",
      "Mienshao",
      "Mightyena",
      "Milotic",
      "Miltank",
      "Mime jr",
      "Mimikyu: Disguised",
      "Minccino",
      "Minior: Red meteor",
      "Minun",
      "Misdreavus",
      "Mismagius",
      "Moltres",
      "Monferno",
      "Morelull",
      "Mothim",
      "Mr-mime",
      "Mudbray",
      "Mudkip",
      "Mudsdale",
      "Muk",
      "Munchlax",
      "Munna",
      "Murkrow",
      "Musharna",
      "Natu",
      "Necrozma",
      "Nidoking",
      "Nidoqueen",
      "Nidoran: Female",
      "Nidoran: Male",
      "Nidorina",
      "Nidorino",
      "Nihilego",
      "Nincada",
      "Ninetales",
      "Ninjask",
      "Noctowl",
      "Noibat",
      "Noivern",
      "Nosepass",
      "Numel",
      "Nuzleaf",
      "Octillery",
      "Oddish",
      "Omanyte",
      "Omastar",
      "Onix",
      "Oranguru",
      "Oricorio: Baile",
      "Oshawott",
      "Pachirisu",
      "Palkia",
      "Palossand",
      "Palpitoad",
      "Pancham",
      "Pangoro",
      "Panpour",
      "Pansage",
      "Pansear",
      "Paras",
      "Parasect",
      "Passimian",
      "Patrat",
      "Pawniard",
      "Pelipper",
      "Persian",
      "Petilil",
      "Phanpy",
      "Phantump",
      "Pheromosa",
      "Phione",
      "Pichu",
      "Pidgeot: Mega",
      "Pidgeot",
      "Pidgeotto",
      "Pidgey",
      "Pidove",
      "Pignite",
      "Pikachu: Belle",
      "Pikachu: Cosplay",
      "Pikachu: Libre",
      "Pikachu: Phd",
      "Pikachu: Pop-star",
      "Pikachu: Rock-star",
      "Pikachu",
      "Pikipek",
      "Piloswine",
      "Pineco",
      "Pinsir: Mega",
      "Pinsir",
      "Piplup",
      "Plusle",
      "Politoed",
      "Poliwag",
      "Poliwhirl",
      "Poliwrath",
      "Ponyta",
      "Poochyena",
      "Popplio",
      "Porygon z",
      "Porygon",
      "Porygon2",
      "Primarina",
      "Primeape",
      "Prinplup",
      "Probopass",
      "Psyduck",
      "Pumpkaboo",
      "Pumpkaboo: Large",
      "Pumpkaboo: Small",
      "Pumpkaboo: Super",
      "Pupitar",
      "Purrloin",
      "Purugly",
      "Pyroar",
      "Pyukumuku",
      "Quagsire",
      "Quilava",
      "Quilladin",
      "Qwilfish",
      "Raichu",
      "Raikou",
      "Ralts",
      "Rampardos",
      "Rapidash",
      "Raticate",
      "Rattata",
      "Rayquaza: Mega",
      "Rayquaza",
      "Regice",
      "Regigigas",
      "Regirock",
      "Registeel",
      "Relicanth",
      "Remoraid",
      "Reshiram",
      "Reuniclus",
      "Rhydon",
      "Rhyhorn",
      "Rhyperior",
      "Ribombee",
      "Riolu",
      "Rockruff",
      "Roggenrola",
      "Roselia",
      "Roserade",
      "Rotom: Fan",
      "Rotom: Frost",
      "Rotom: Heat",
      "Rotom: Mow",
      "Rotom: Wash",
      "Rotom",
      "Rowlet",
      "Rufflet",
      "Sableye: Mega",
      "Sableye",
      "Salamence: Mega",
      "Salamence",
      "Salandit",
      "Salazzle",
      "Samurott",
      "Sandile",
      "Sandshrew",
      "Sandslash",
      "Sandygast",
      "Sawk",
      "Sawsbuck",
      "Scatterbug",
      "Sceptile: Mega",
      "Sceptile",
      "Scizor: Mega",
      "Scizor",
      "Scolipede",
      "Scrafty",
      "Scraggy",
      "Scyther",
      "Seadra",
      "Seaking",
      "Sealeo",
      "Seedot",
      "Seel",
      "Seismitoad",
      "Sentret",
      "Serperior",
      "Servine",
      "Seviper",
      "Sewaddle",
      "Sharpedo: Mega",
      "Sharpedo",
      "Shaymin: Land",
      "Shaymin: Sky",
      "Shedinja",
      "Shelgon",
      "Shellder",
      "Shellos",
      "Shelmet",
      "Shieldon",
      "Shiftry",
      "Shiinotic",
      "Shinx",
      "Shroomish",
      "Shuckle",
      "Shuppet",
      "Sigilyph",
      "Silcoon",
      "Silvally",
      "Simipour",
      "Simisage",
      "Simisear",
      "Skarmory",
      "Skiddo",
      "Skiploom",
      "Skitty",
      "Skorupi",
      "Skrelp",
      "Skuntank",
      "Slaking",
      "Slakoth",
      "Sliggoo",
      "Slowbro: Mega",
      "Slowbro",
      "Slowking",
      "Slowpoke",
      "Slugma",
      "Slurpuff",
      "Smeargle",
      "Smoochum",
      "Sneasel",
      "Snivy",
      "Snorlax",
      "Snorunt",
      "Snover",
      "Snubbull",
      "Solgaleo",
      "Solosis",
      "Solrock",
      "Spearow",
      "Spewpa",
      "Spheal",
      "Spinarak",
      "Spinda",
      "Spiritomb",
      "Spoink",
      "Spritzee",
      "Squirtle",
      "Stantler",
      "Staraptor",
      "Staravia",
      "Starly",
      "Starmie",
      "Staryu",
      "Steelix: Mega",
      "Steelix",
      "Steenee",
      "Stoutland",
      "Stufful",
      "Stunfisk",
      "Stunky",
      "Sudowoodo",
      "Suicune",
      "Sunflora",
      "Sunkern",
      "Surskit",
      "Swablu",
      "Swadloon",
      "Swalot",
      "Swampert: Mega",
      "Swampert",
      "Swanna",
      "Swellow",
      "Swinub",
      "Swirlix",
      "Swoobat",
      "Sylveon",
      "Taillow",
      "Talonflame",
      "Tangela",
      "Tangrowth",
      "Tapu: Bulu",
      "Tapu: Fini",
      "Tapu: Koko",
      "Tapu: Lele",
      "Tauros",
      "Teddiursa",
      "Tentacool",
      "Tentacruel",
      "Tepig",
      "Terrakion",
      "Throh",
      "Thundurus: Incarnate",
      "Thundurus: Therian",
      "Timburr",
      "Tirtouga",
      "Togedemaru",
      "Togekiss",
      "Togepi",
      "Togetic",
      "Torchic",
      "Torkoal",
      "Tornadus: Incarnate",
      "Tornadus: Therian",
      "Torracat",
      "Torterra",
      "Totodile",
      "Toucannon",
      "Toxapex",
      "Toxicroak",
      "Tranquill",
      "Trapinch",
      "Treecko",
      "Trevenant",
      "Tropius",
      "Trubbish",
      "Trumbeak",
      "Tsareena",
      "Turtonator",
      "Turtwig",
      "Tympole",
      "Tynamo",
      "Type: Null",
      "Typhlosion",
      "Tyranitar: Mega",
      "Tyranitar",
      "Tyrantrum",
      "Tyrogue",
      "Tyrunt",
      "Umbreon",
      "Unfezant",
      "Unown",
      "Ursaring",
      "Uxie",
      "Vanillish",
      "Vanillite",
      "Vanilluxe",
      "Vaporeon",
      "Venipede",
      "Venomoth",
      "Venonat",
      "Venusaur: Mega",
      "Venusaur",
      "Vespiquen",
      "Vibrava",
      "Victini",
      "Victreebel",
      "Vigoroth",
      "Vikavolt",
      "Vileplume",
      "Virizion",
      "Vivillon",
      "Volbeat",
      "Volcanion",
      "Volcarona",
      "Voltorb",
      "Vullaby",
      "Vulpix",
      "Wailmer",
      "Wailord",
      "Walrein",
      "Wartortle",
      "Watchog",
      "Weavile",
      "Weedle",
      "Weepinbell",
      "Weezing",
      "Whimsicott",
      "Whirlipede",
      "Whiscash",
      "Whismur",
      "Wigglytuff",
      "Wimpod",
      "Wingull",
      "Wishiwashi: Solo",
      "Wobbuffet",
      "Woobat",
      "Wooper",
      "Wormadam: Plant",
      "Wormadam: Sandy",
      "Wormadam: Trash",
      "Wurmple",
      "Wynaut",
      "Xatu",
      "Xerneas",
      "Xurkitree",
      "Yamask",
      "Yanma",
      "Yanmega",
      "Yungoos",
      "Yveltal",
      "Zangoose",
      "Zapdos",
      "Zebstrika",
      "Zekrom",
      "Zigzagoon",
      "Zoroark",
      "Zorua",
      "Zubat",
      "Zweilous",
      "Zygarde",
    ]);

    /* src/App.svelte generated by Svelte v3.17.0 */

    const { document: document_1 } = globals;
    const file = "src/App.svelte";

    function get_each_context_1(ctx, list, i) {
    	const child_ctx = ctx.slice();
    	child_ctx[6] = list[i];
    	return child_ctx;
    }

    function get_each_context(ctx, list, i) {
    	const child_ctx = ctx.slice();
    	child_ctx[3] = list[i];
    	return child_ctx;
    }

    // (44:6) {:else}
    function create_else_block(ctx) {
    	let span;
    	let t_value = /*part*/ ctx[6].value + "";
    	let t;

    	const block = {
    		c: function create() {
    			span = element("span");
    			t = text(t_value);
    			add_location(span, file, 44, 7, 978);
    		},
    		m: function mount(target, anchor) {
    			insert_dev(target, span, anchor);
    			append_dev(span, t);
    		},
    		p: function update(ctx, dirty) {
    			if (dirty & /*foundPokemon*/ 2 && t_value !== (t_value = /*part*/ ctx[6].value + "")) set_data_dev(t, t_value);
    		},
    		d: function destroy(detaching) {
    			if (detaching) detach_dev(span);
    		}
    	};

    	dispatch_dev("SvelteRegisterBlock", {
    		block,
    		id: create_else_block.name,
    		type: "else",
    		source: "(44:6) {:else}",
    		ctx
    	});

    	return block;
    }

    // (42:6) {#if part.isUsed}
    function create_if_block(ctx) {
    	let strong;
    	let t_value = /*part*/ ctx[6].value + "";
    	let t;

    	const block = {
    		c: function create() {
    			strong = element("strong");
    			t = text(t_value);
    			attr_dev(strong, "class", "svelte-9jjdng");
    			add_location(strong, file, 42, 7, 927);
    		},
    		m: function mount(target, anchor) {
    			insert_dev(target, strong, anchor);
    			append_dev(strong, t);
    		},
    		p: function update(ctx, dirty) {
    			if (dirty & /*foundPokemon*/ 2 && t_value !== (t_value = /*part*/ ctx[6].value + "")) set_data_dev(t, t_value);
    		},
    		d: function destroy(detaching) {
    			if (detaching) detach_dev(strong);
    		}
    	};

    	dispatch_dev("SvelteRegisterBlock", {
    		block,
    		id: create_if_block.name,
    		type: "if",
    		source: "(42:6) {#if part.isUsed}",
    		ctx
    	});

    	return block;
    }

    // (41:5) {#each pokemonName.searchParts as part}
    function create_each_block_1(ctx) {
    	let if_block_anchor;

    	function select_block_type(ctx, dirty) {
    		if (/*part*/ ctx[6].isUsed) return create_if_block;
    		return create_else_block;
    	}

    	let current_block_type = select_block_type(ctx);
    	let if_block = current_block_type(ctx);

    	const block = {
    		c: function create() {
    			if_block.c();
    			if_block_anchor = empty();
    		},
    		m: function mount(target, anchor) {
    			if_block.m(target, anchor);
    			insert_dev(target, if_block_anchor, anchor);
    		},
    		p: function update(ctx, dirty) {
    			if (current_block_type === (current_block_type = select_block_type(ctx)) && if_block) {
    				if_block.p(ctx, dirty);
    			} else {
    				if_block.d(1);
    				if_block = current_block_type(ctx);

    				if (if_block) {
    					if_block.c();
    					if_block.m(if_block_anchor.parentNode, if_block_anchor);
    				}
    			}
    		},
    		d: function destroy(detaching) {
    			if_block.d(detaching);
    			if (detaching) detach_dev(if_block_anchor);
    		}
    	};

    	dispatch_dev("SvelteRegisterBlock", {
    		block,
    		id: create_each_block_1.name,
    		type: "each",
    		source: "(41:5) {#each pokemonName.searchParts as part}",
    		ctx
    	});

    	return block;
    }

    // (38:2) {#each foundPokemon as pokemonName}
    function create_each_block(ctx) {
    	let li;
    	let h4;
    	let t0;
    	let img;
    	let img_src_value;
    	let t1;
    	let each_value_1 = /*pokemonName*/ ctx[3].searchParts;
    	let each_blocks = [];

    	for (let i = 0; i < each_value_1.length; i += 1) {
    		each_blocks[i] = create_each_block_1(get_each_context_1(ctx, each_value_1, i));
    	}

    	const block = {
    		c: function create() {
    			li = element("li");
    			h4 = element("h4");

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].c();
    			}

    			t0 = space();
    			img = element("img");
    			t1 = space();
    			attr_dev(h4, "class", "svelte-9jjdng");
    			add_location(h4, file, 39, 4, 846);
    			if (img.src !== (img_src_value = "./pokemon-images/" + /*pokemonName*/ ctx[3].id + ".png")) attr_dev(img, "src", img_src_value);
    			attr_dev(img, "alt", "");
    			attr_dev(img, "role", "presentation");
    			attr_dev(img, "loading", "lazy");
    			attr_dev(img, "class", "svelte-9jjdng");
    			add_location(img, file, 49, 4, 1044);
    			attr_dev(li, "class", "svelte-9jjdng");
    			add_location(li, file, 38, 3, 837);
    		},
    		m: function mount(target, anchor) {
    			insert_dev(target, li, anchor);
    			append_dev(li, h4);

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].m(h4, null);
    			}

    			append_dev(li, t0);
    			append_dev(li, img);
    			append_dev(li, t1);
    		},
    		p: function update(ctx, dirty) {
    			if (dirty & /*foundPokemon*/ 2) {
    				each_value_1 = /*pokemonName*/ ctx[3].searchParts;
    				let i;

    				for (i = 0; i < each_value_1.length; i += 1) {
    					const child_ctx = get_each_context_1(ctx, each_value_1, i);

    					if (each_blocks[i]) {
    						each_blocks[i].p(child_ctx, dirty);
    					} else {
    						each_blocks[i] = create_each_block_1(child_ctx);
    						each_blocks[i].c();
    						each_blocks[i].m(h4, null);
    					}
    				}

    				for (; i < each_blocks.length; i += 1) {
    					each_blocks[i].d(1);
    				}

    				each_blocks.length = each_value_1.length;
    			}

    			if (dirty & /*foundPokemon*/ 2 && img.src !== (img_src_value = "./pokemon-images/" + /*pokemonName*/ ctx[3].id + ".png")) {
    				attr_dev(img, "src", img_src_value);
    			}
    		},
    		d: function destroy(detaching) {
    			if (detaching) detach_dev(li);
    			destroy_each(each_blocks, detaching);
    		}
    	};

    	dispatch_dev("SvelteRegisterBlock", {
    		block,
    		id: create_each_block.name,
    		type: "each",
    		source: "(38:2) {#each foundPokemon as pokemonName}",
    		ctx
    	});

    	return block;
    }

    function create_fragment(ctx) {
    	let t0;
    	let main;
    	let input;
    	let t1;
    	let ul;
    	let dispose;
    	let each_value = /*foundPokemon*/ ctx[1];
    	let each_blocks = [];

    	for (let i = 0; i < each_value.length; i += 1) {
    		each_blocks[i] = create_each_block(get_each_context(ctx, each_value, i));
    	}

    	const block = {
    		c: function create() {
    			t0 = space();
    			main = element("main");
    			input = element("input");
    			t1 = space();
    			ul = element("ul");

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].c();
    			}

    			document_1.title = "Fuzzy search";
    			attr_dev(input, "id", "search");
    			attr_dev(input, "type", "text");
    			attr_dev(input, "placeholder", "begin typing...");
    			attr_dev(input, "autocomplete", "off");
    			attr_dev(input, "aria-label", "Search pokémon");
    			attr_dev(input, "class", "svelte-9jjdng");
    			add_location(input, file, 27, 1, 635);
    			attr_dev(ul, "class", "svelte-9jjdng");
    			add_location(ul, file, 36, 1, 791);
    			add_location(main, file, 26, 0, 627);
    		},
    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},
    		m: function mount(target, anchor) {
    			insert_dev(target, t0, anchor);
    			insert_dev(target, main, anchor);
    			append_dev(main, input);
    			set_input_value(input, /*searchTerm*/ ctx[0]);
    			append_dev(main, t1);
    			append_dev(main, ul);

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].m(ul, null);
    			}

    			dispose = listen_dev(input, "input", /*input_input_handler*/ ctx[2]);
    		},
    		p: function update(ctx, [dirty]) {
    			if (dirty & /*searchTerm*/ 1 && input.value !== /*searchTerm*/ ctx[0]) {
    				set_input_value(input, /*searchTerm*/ ctx[0]);
    			}

    			if (dirty & /*foundPokemon*/ 2) {
    				each_value = /*foundPokemon*/ ctx[1];
    				let i;

    				for (i = 0; i < each_value.length; i += 1) {
    					const child_ctx = get_each_context(ctx, each_value, i);

    					if (each_blocks[i]) {
    						each_blocks[i].p(child_ctx, dirty);
    					} else {
    						each_blocks[i] = create_each_block(child_ctx);
    						each_blocks[i].c();
    						each_blocks[i].m(ul, null);
    					}
    				}

    				for (; i < each_blocks.length; i += 1) {
    					each_blocks[i].d(1);
    				}

    				each_blocks.length = each_value.length;
    			}
    		},
    		i: noop,
    		o: noop,
    		d: function destroy(detaching) {
    			if (detaching) detach_dev(t0);
    			if (detaching) detach_dev(main);
    			destroy_each(each_blocks, detaching);
    			dispose();
    		}
    	};

    	dispatch_dev("SvelteRegisterBlock", {
    		block,
    		id: create_fragment.name,
    		type: "component",
    		source: "",
    		ctx
    	});

    	return block;
    }

    function instance($$self, $$props, $$invalidate) {
    	let searchTerm = "";

    	onMount(() => {
    		document.querySelector("input").focus();
    	});

    	function input_input_handler() {
    		searchTerm = this.value;
    		$$invalidate(0, searchTerm);
    	}

    	$$self.$capture_state = () => {
    		return {};
    	};

    	$$self.$inject_state = $$props => {
    		if ("searchTerm" in $$props) $$invalidate(0, searchTerm = $$props.searchTerm);
    		if ("foundPokemon" in $$props) $$invalidate(1, foundPokemon = $$props.foundPokemon);
    	};

    	let foundPokemon;

    	$$self.$$.update = () => {
    		if ($$self.$$.dirty & /*searchTerm*/ 1) {
    			 $$invalidate(1, foundPokemon = getFuzzyMatchArray(searchTerm, allPokemonNames, true).filter(match => !!match.isFullMatch).map(match => ({
    				id: match.string.replace(/[- :]+/g, "-").toLowerCase(),
    				searchParts: match.parts.map(part => ({ value: part.value, isUsed: part.isUsed }))
    			})));
    		}
    	};

    	return [searchTerm, foundPokemon, input_input_handler];
    }

    class App extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance, create_fragment, safe_not_equal, {});

    		dispatch_dev("SvelteRegisterComponent", {
    			component: this,
    			tagName: "App",
    			options,
    			id: create_fragment.name
    		});
    	}
    }

    const app = new App({ target: document.body });

    return app;

}());
//# sourceMappingURL=bundle.js.map
