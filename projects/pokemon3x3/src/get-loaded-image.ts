export default async function getLoadedImage(src): Promise<HTMLImageElement>  {
  let imageResponse = await fetch(src);
  if (!["2", "3"].includes(String(imageResponse.status).slice(0, 1))) {
    throw `Image is borked with status: ${imageResponse.status}`;
  }
  let imageBlob = await imageResponse.blob();
  let imageDataURL = URL.createObjectURL(imageBlob);

  let img = new Image();
  img.src = imageDataURL;
  return new Promise((resolve, reject) => {
    img.addEventListener("load", () => {
      resolve(img);
    }, { once: true });
    img.addEventListener("error", () => {
      reject("Image creation failed");
    }, { once: true });
  });
}
