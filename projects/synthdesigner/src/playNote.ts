import { audioContext } from "./audioContext.js";

const SILENCE = 1.401e-45;
const VOLUME = 0.4;
const susCurve = 2.3;
const minRelease = 0.002;
const sus = (linearSustain = 1) =>
  (Math.exp(susCurve) ** linearSustain - 1) / (Math.exp(susCurve) - 1);

interface Note {
  oscillatorNode: OscillatorNode;
  gainNode: GainNode;
}
const activeNotes = new Set<Note>();

export const endAllNotes = () => {
  activeNotes.forEach((note) => {
    // Stop sustain from draining the sound
    note.gainNode.gain.cancelScheduledValues(audioContext.currentTime);
    // I don’t understand why this is needed…
    note.gainNode.gain.setValueAtTime(
      note.gainNode.gain.value,
      audioContext.currentTime
    );

    const stopTime = audioContext.currentTime + minRelease;
    note.gainNode.gain.linearRampToValueAtTime(SILENCE, stopTime);
    note.oscillatorNode.stop(stopTime);

    note.oscillatorNode.addEventListener("ended", () => {
      activeNotes.delete(note);
    });
  });
};

const releaseNote = (note: Note, release: number) => {
  // Stop sustain from draining the sound
  note.gainNode.gain.cancelScheduledValues(audioContext.currentTime);
  // I don’t understand why this is needed…
  note.gainNode.gain.setValueAtTime(
    note.gainNode.gain.value,
    audioContext.currentTime
  );

  const stopTime = audioContext.currentTime + Math.max(minRelease, release);
  note.gainNode.gain.linearRampToValueAtTime(SILENCE, stopTime);
  note.oscillatorNode.stop(stopTime);

  note.oscillatorNode.addEventListener("ended", () => {
    activeNotes.delete(note);
  });
};

interface Props {
  frequency?: number;
  attack?: number;
  waveShape?: OscillatorType;
  forceFullAttack?: boolean;
  decay?: number;
  sustain?: number;
  release?: number;
}

export const playNote = ({
  frequency = 440,
  attack: attackMs = 10,
  waveShape = "sine",
  forceFullAttack = false,
  decay: decayMs = 2000,
  sustain = 0,
  release: releaseMs = 100,
}: Props = {}) => {
  const attack = attackMs / 1000;
  const release = releaseMs / 1000;
  const decay = decayMs / 1000;
  const pressTime = audioContext.currentTime;

  const gainNode = audioContext.createGain();
  gainNode.connect(audioContext.destination);
  gainNode.gain.value = 0;
  gainNode.gain.linearRampToValueAtTime(
    VOLUME,
    audioContext.currentTime + attack
  );

  const oscillatorNode = audioContext.createOscillator();
  oscillatorNode.connect(gainNode);
  oscillatorNode.type = waveShape;
  oscillatorNode.frequency.setValueAtTime(frequency, audioContext.currentTime);

  const sustainTimeout = setTimeout(() => {
    gainNode.gain.linearRampToValueAtTime(
      Math.max(VOLUME * sus(sustain), SILENCE),
      audioContext.currentTime + decay
    );
  }, attackMs);

  oscillatorNode.start();
  const note = { oscillatorNode, gainNode };
  activeNotes.add(note);

  return {
    release() {
      const releaseTime = audioContext.currentTime;
      clearTimeout(sustainTimeout);

      if (forceFullAttack && attack + pressTime > releaseTime) {
        setTimeout(() => {
          releaseNote(note, release);
        }, (attack + pressTime - releaseTime) * 1000);
      } else {
        // if (attack + pressTime > releaseTime) {
        //   gainNode.gain.cancelAndHoldAtTime(audioContext.currentTime);
        // }
        releaseNote(note, release);
      }
    },
  };
};
