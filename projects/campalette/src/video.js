const readyFuncs = [];
let video      = document.createElement('video');
let isReady      = false;

navigator.mediaDevices
  .getUserMedia({
      video: true
  })
  .then((stream) => {
      video.srcObject = stream;
      video.play();

      video.onplaying = () => {
        isReady = true;
        readyFuncs.forEach(func => { func(video); });
      };
  });

export default video;
export function onReady(func) {
  if (isReady) {
    func(video);
  } else {
    readyFuncs.push(func);
  }
}
