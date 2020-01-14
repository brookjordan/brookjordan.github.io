<script>
	import { onMount } from 'svelte';
	import fuzzySearch from "./fuzzy-search.js";
	import allPokemonNames from "./pokemon-names.js";

	let searchTerm = "";
	$: foundPokemon = fuzzySearch(searchTerm, allPokemonNames, true )
		.filter(match => !!match.isFullMatch)
		.map(match => ({
			id: match.string.replace(/[- :]+/g, '-').toLowerCase(),
			searchParts: match.parts.map(part => ({
				value: part.value,
				isUsed: part.isUsed,
			})),
		}));

	onMount(() => {
		// autofocus doesn't seem to work
		document.querySelector('input').focus();
	});
</script>

<svelte:head>
	<title>Fuzzy search</title>
</svelte:head>

<main>
	<input 
		id="search" 
		type="text" 
		placeholder="begin typing..." 
		autocomplete="off" 
		aria-label="Search pokémon"
		bind:value="{searchTerm}"
	>

	<ul>
		{#each foundPokemon as pokemonName}
			<li>
				<h4>
					{#each pokemonName.searchParts as part}
						{#if part.isUsed}
							<strong>{part.value}</strong>
						{:else}
							<span>{part.value}</span>
						{/if}
					{/each}
				</h4>

				<img
				  src="./pokemon-images/{pokemonName.id}.png"
					alt=""
					role="presentation"
					loading="lazy"
				>
			</li>
		{/each}
	</ul>
</main>

<style>
	@keyframes resultBuild {
		from {
			max-width: 0;
		}

		to {
			max-width: 300px;
		}
	}

	strong {
		background: hsla(240, 99%, 65%, 0.1);
		color: hsl(240, 40%, 65%);
		padding: 0.2rem 0;
		padding-left: 0.3rem;
		margin-right: 0.3rem;
		border-radius: 0.3rem;
	}

	ul {
		display: flex;
		flex-wrap: wrap;
		padding: 0;
		margin: 0;
	}

	li {
		display: flex;
    justify-content: center;
		min-width: 137px; /* min with with text and image */
		padding: 5px 20px;
		margin: 5px;
		box-shadow: 0 1px 2px #999;

		flex-grow: 1;

		list-style: none;

		text-align: center;
		height: 50px;
		line-height: 50px;

		background: white;

		animation-name: resultBuild;
		animation-duration: .15s;
	}

	li > h4 {
		margin: 0;
		font: inherit;
	}


	li img {
		vertical-align: middle;
		max-height: 50px;
		image-rendering: pixelated;
		image-rendering: crisp-edges;
		transform: scale(1);
		transition: transform 0.15s;
		pointer-events: none;
	}

	li:hover img {
		position: relative;
		transform: scale(4);
		z-index: 2;
	}

	#search {
		position: fixed;
		top: 20px;
		left: 10px;
		z-index: 1;

		font-size: 2rem;
		text-align: center;
		width: calc(100% - 20px);
		border: none;
		padding: 5px 0;
		margin-bottom: 20px;
		outline: none;
		background: rgba(255, 255, 255, 0.9);
		opacity: 0.2;

		box-shadow: 0 0 2px #666;

		transition: box-shadow .2s, opacity .2s;
	}

	#search:focus {
		box-shadow: 0 0 8px #999;
		opacity: 1;
	}
</style>
