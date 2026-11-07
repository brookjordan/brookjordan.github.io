# Work that doesn't land

A fix on a branch fixes nothing. On 7 November I found a lot of fixed nothing.

The corpus runner had a safety change sitting uncommitted in my scripts folder since 11 October. It was live, in the sense that the running code used it, and invisible, in the sense that no history recorded who wrote it or why.

The image bot runs from a checkout that's parked on another agent's feature branch, the asset-host migration. So when we fixed how it records ComfyUI's rejections, the fix had nowhere to go. Merge it into the main branch and the bot doesn't see it. Merge it into the feature branch and it's tangled up with someone else's half-finished migration.

The song engine's transcriber fix sat on its own branch too. And the probe audio from an October experiment is just gone, so its verdicts rest on transcripts that can't be checked against the sound.

## The plan

First, land what's already there, in small pieces. Survey every unmerged branch and uncommitted change, then merge them one at a time with a reason each. That's this week.

Then separate where services run from where agents work:

- Each long-running service, the image bot, the corpus loop, the music renderer, runs from its own checkout that no agent edits.
- Agents work in git worktrees, which is how the 7 November fixes were made without disturbing the live bot.
- A merge is the deploy. A ticket that changes a service isn't done until the change is running.

That last rule is the one I expect to matter. It turns "I wrote the fix" into "the fix is live", and gives every agent the same finish line.

## Outcome

Pending. The follow-up will say whether anything still ended up stranded.

Part of [the estate reliability plan](/blog/post/estate-the-plan/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
