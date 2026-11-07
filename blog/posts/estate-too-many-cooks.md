# Too many cooks

I run a lot of side projects on one laptop. A song engine that writes a news podcast's opening song. A podcast builder. An image gallery that renders every model against every scene. Local video, local speech, a research corpus that a pair of AI agents grind through overnight. None of it is work. It's what I do for fun.

Most of the doing is done by agents now. Claude, Hermes, DeepSeek's harness, a couple of local models. They are very good at starting things.

On 7 November I asked one of them to find the low-hanging fruit across these projects. It counted what was open first. The podcast builder had 26 tickets in progress. The song engine had 16. The image gallery had 10. "In progress" mostly meant "someone claimed it once". I didn't check how many of the agents behind those claims are still running. Nothing does.

That's the problem in one sentence. Work gets started faster than it gets finished, and a started ticket looks exactly like a live one.

## What we did that day

We picked the small stuff. Index two missing notes. Trim a document that had grown past its size budget. Teach the song checker to use the transcriber that actually exists on this machine. Make the image bot record why ComfyUI refused a job instead of just "rejected: 400". Six tickets closed in one sitting, each with a test or a measurement behind it.

Small tickets are where the hidden problems live. The transcriber fix turned up a renderer that had been dead for who knows how long while its watchdog logged "started" every five minutes. The image bot fix turned up a production checkout parked on someone else's feature branch. Neither would have surfaced from the big, interesting tickets.

## How we're going to prioritise

These are fun projects, so there is no roadmap and there shouldn't be one. The order is:

1. Easy and unblocked first. Clear the frontier so the real choices are visible.
2. Then whatever's interesting that day.
3. Blocked work waits for its blocker, and the blocker is just another ticket.

The rules that make that work:

- A claim expires. If a ticket hasn't changed in 48 hours, it goes back on the pile, and whoever claimed it can pick it up again.
- Each project gets a cap on work in progress, about five. A new ticket starts when an old one finishes.
- Done means landed. A ticket that changes a service is done when the change is running, not when the code exists on a branch.

## Outcome

Pending. I'll write a follow-up after a few weeks with the claim-expiry check running, and say whether the in-progress counts actually came down.

Part of [the estate reliability plan](/blog/post/estate-the-plan/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
