export let audioContext;
export const init = () => {
    audioContext = new AudioContext({
        latencyHint: "interactive",
    });
};
