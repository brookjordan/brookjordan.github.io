# Alarms that watch flow

My alarms fire when something crashes. None of the failures I found on 7 November crashed.

The renderer exited cleanly and its watchdog logged success. The corpus deferred politely, every two minutes, for two days. Nothing threw. Everything was fine except that nothing was being made.

So the alarm should watch the thing I care about, which is output. For each pipeline, two questions:

- When did it last deliver something? A note, a song, an image, an episode.
- How long has it been deferring or retrying in a row?

If either crosses a line, one Telegram message, deduplicated, with the log line that explains it. A planted stall in a test should produce exactly one message. The corpus stall from 5 November should have produced one within a day.

This depends on the logs being honest, which is why it comes after [silent failures aren't logless](/blog/post/estate-silent-failures/). An alarm reading a log that says "started" when the server is dead will happily report that everything is fine.

## Outcome

Pending. The follow-up will list what the alarms caught, and anything they missed.

Part of [the estate reliability plan](/blog/post/estate-the-plan/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
