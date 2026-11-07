# Silent failures aren't logless

I keep telling my agents to log more. When something breaks quietly, I assume it broke without leaving a trace. On 7 November we went looking at three quiet failures, and every one of them had a log.

The music renderer was down. Its watchdog had been writing `"status":"started"` every five minutes the whole time. The script launched the server, saw it answer once, logged success and exited. Then launchd tidied up after the finished job, which includes killing anything it left running. The log was there. It was wrong.

The research corpus hadn't run since 23 October. Its reconciler wrote 1,189 `run-deferred` lines in two days, every one of them saying exactly why: free swap was 1.2 GB, below a 2 GB floor. The log was there and it was right. Nobody read it. And the reason itself was a bad measurement, because macOS grows swap on demand and the machine had 90% of its memory free.

The song checker's transcription step needed a whisper binary that no longer exists. The script checked for it and exited with the missing path. It just never ran, because nothing called it until a probe needed a transcript.

So the logs weren't missing. They were wrong, unread or never triggered.

## What a log has to do

Three rules, and I'm putting them in the instructions every agent loads:

1. Log the outcome you verified, not the thing you tried. "Started" is only true once the health check answers again a minute later.
2. Log for a machine. One timestamped JSON line per state change, so a script can read the history without a person.
3. Every log needs a reader. Something that looks at the shape of it, like "ten deferrals in a row" or "no delivery in 24 hours", and tells me.

The third one is the point. I can't anticipate every failure, and I'll keep missing the error I should have thrown or the retry I should have written. If the log records what actually happened, and something watches it, I find out without having to re-run anything. Logs first, as the last line of defence, rather than added after the next outage.

## Outcome

Pending. The follow-up will count how many failures over the next few weeks were caught from the logs alone.

Part of [the estate reliability plan](/blog/post/estate-the-plan/). The alarm half is in [alarms that watch flow](/blog/post/estate-alarms-on-flow/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
