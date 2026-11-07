# The estate reliability plan

These are the plans, written before building them. Each one gets a second post later, once it has been running for a few weeks, saying how it actually went. I'll update the outcome lines here as those land.

It started on 7 November, when I asked an agent to pick off easy tickets across my side projects and it kept finding things that had quietly stopped. A dead music renderer. A research corpus that hadn't run in two weeks. Fixes stranded on branches. The pattern was the same each time: the work was started, the logs existed, and nothing noticed.

- [Too many cooks](/blog/post/estate-too-many-cooks/). Work starts faster than it finishes. Claims expire, work in progress gets a cap, done means landed. Outcome: pending.
- [Silent failures aren't logless](/blog/post/estate-silent-failures/). The logs were there but wrong or unread. Log verified outcomes, as structured lines, and give every log a reader. Outcome: pending.
- [Work that doesn't land](/blog/post/estate-unlanded-work/). Land the stranded work, then run services from checkouts no agent edits. Outcome: pending.
- [Taking turns on one machine](/blog/post/estate-taking-turns/). One M5, many model servers. A GPU lease decides whose turn it is. Outcome: pending.
- [Keeping the evidence](/blog/post/estate-keeping-evidence/). Finished artefacts go to the NAS with checksums, so a result can still be checked a month later. Outcome: pending.
- [Alarms that watch flow](/blog/post/estate-alarms-on-flow/). Alarm on "nothing has been delivered", not only on crashes. Outcome: pending.

Two things were fixed the same day, before any of this was written up. The renderer's watchdog now leaves the server running when it exits. And the corpus checks available memory rather than free swap, which had held every run back since 5 November.

This is all for fun. There's no schedule, and the order is easy and unblocked first, then whatever's interesting.

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
