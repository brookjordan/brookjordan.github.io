# Taking turns on one machine

Everything runs on one M5 MacBook with 48 GB of memory. The music renderer, a 21 GB local language model for the research corpus, ComfyUI for images and video, a speech recogniser, and whatever an agent decides to try this afternoon. That isn't going to change. There's no second machine, and I don't want one.

So the question isn't how to run less. It's how to take turns.

Right now each server has its own watchdog, and each watchdog only knows about itself. The renderer's watchdog restarts the renderer. The corpus reconciler checks memory before loading its model. ComfyUI has its own profile switcher. They don't talk to each other. The corpus notes already record two copies of its 21 GB model thrashing swap until the machine stopped answering, and nothing stops two different servers doing the same.

The podcast builder already has the start of an answer: a GPU lease. One file says which profile owns the heavy hardware right now, song, image, video, language model or none. Taking the lease stops the others and remembers what to restart. Handing it back restores them. The renderer's starter checks it. I haven't confirmed that anything else does.

## The plan

Make the lease the scheduler for everything heavy. Every model server asks for it before loading, and a second one can't load while the first holds it. The order stays mine: whichever project is most interesting gets the machine, and the rest wait their turn rather than fighting over memory.

The memory check needs fixing too. The corpus gate deferred every run for two days because it read free swap, and macOS grows swap on demand. Available memory is the honest number. That part is already fixed. The lease is next.

## Outcome

Pending. The follow-up will say whether any two heavy jobs still collided, and whether the queue felt fair.

Part of [the estate reliability plan](/blog/post/estate-the-plan/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
