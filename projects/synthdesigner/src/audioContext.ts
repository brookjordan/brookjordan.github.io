export let audioContext: AudioContext;

export const init = () => {
  audioContext = new AudioContext({
    latencyHint: "interactive",
  });
};
