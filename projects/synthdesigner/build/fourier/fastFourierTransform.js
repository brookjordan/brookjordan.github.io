import bitLength from "./bitLength.js";
import ComplexNumber from "./complexNumber.js";
/**
 * Returns the number which is the flipped binary representation of input.
 */
function reverseBits(input, bitsCount) {
    let reversedBits = 0;
    for (let bitIndex = 0; bitIndex < bitsCount; bitIndex += 1) {
        reversedBits *= 2;
        if (Math.floor(input / (1 << bitIndex)) % 2 === 1) {
            reversedBits += 1;
        }
    }
    return reversedBits;
}
/**
 * Returns the radix-2 fast fourier transform of the given array.
 * Optionally computes the radix-2 inverse fast fourier transform.
 */
export default function fastFourierTransform(inputData, inverse = false) {
    const bitsCount = bitLength(inputData.length - 1);
    const N = 1 << bitsCount;
    while (inputData.length < N) {
        inputData.push(new ComplexNumber(0));
    }
    const output = Array.from({ length: N }, (_, dataSampleIndex) => inputData[reverseBits(dataSampleIndex, bitsCount)]);
    for (let blockLength = 2; blockLength <= N; blockLength *= 2) {
        const imaginarySign = inverse ? -1 : 1;
        const phaseStep = new ComplexNumber({
            real: Math.cos((2 * Math.PI) / blockLength),
            imaginary: imaginarySign * Math.sin((2 * Math.PI) / blockLength),
        });
        for (let blockStart = 0; blockStart < N; blockStart += blockLength) {
            let phase = new ComplexNumber({ real: 1, imaginary: 0 });
            for (let signalId = blockStart; signalId < blockStart + blockLength / 2; signalId += 1) {
                const component = output[signalId + blockLength / 2].multiply(phase);
                const upd1 = output[signalId].add(component);
                const upd2 = output[signalId].subtract(component);
                output[signalId] = upd1;
                output[signalId + blockLength / 2] = upd2;
                phase = phase.multiply(phaseStep);
            }
        }
    }
    if (inverse) {
        for (let signalId = 0; signalId < N; signalId += 1) {
            output[signalId] = output[signalId].multiply(N);
        }
    }
    return output;
}
