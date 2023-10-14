﻿import ComplexNumber from "./complexNumber.js";

const CLOSE_TO_ZERO_THRESHOLD = 1e-10;

/**
 * Discrete Fourier Transform (DFT): time to frequencies.
 *
 * Time complexity: O(N^2)
 *
 * @param inputAmplitudes - Input signal amplitudes over time (complex numbers with real parts only).
 * @param zeroThreshold - Threshold that is used to convert real and imaginary numbers
 * to zero in case if they are smaller then this.
 *
 * @return - Array of complex number. Each of the number represents the frequency or signal. All signals together will form input signal over discrete time periods. Each signal's
 * complex number has radius (amplitude) and phase (angle) in polar form that describes the signal.
 *
 * @see https://gist.github.com/anonymous/129d477ddb1c8025c9ac
 * @see https://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/
 */
export default function discreteFourierTransform(
  // Input signal amplitudes over time (complex numbers with real parts only).
  inputAmplitudes: number[],
  // Array of complex number. Each of the number represents the frequency or signal. All signals together will form input signal over discrete time periods. Each signal's
  zeroThreshold = CLOSE_TO_ZERO_THRESHOLD
) {
  const N = inputAmplitudes.length;
  const signals: ComplexNumber[] = [];

  // Go through every discrete frequency.
  for (let frequency = 0; frequency < N; frequency += 1) {
    // Compound signal at current frequency that will ultimately
    //   take part in forming input amplitudes.
    let frequencySignal = new ComplexNumber(0);

    // Go through every discrete point in time.
    for (let timer = 0; timer < N; timer += 1) {
      const currentAmplitude = inputAmplitudes[timer];

      // Calculate rotation angle.
      const rotationAngle = -1 * (2 * Math.PI) * frequency * (timer / N);

      // Remember that e^ix = cos(x) + i * sin(x);
      const dataPointContribution = new ComplexNumber({
        real: Math.cos(rotationAngle),
        imaginary: Math.sin(rotationAngle),
      }).multiply(currentAmplitude);

      // Add this data point's contribution.
      frequencySignal = frequencySignal.add(dataPointContribution);
    }

    // Close to zero? You're zero.
    if (Math.abs(frequencySignal.real) < zeroThreshold) {
      frequencySignal.real = 0;
    }

    if (Math.abs(frequencySignal.imaginary) < zeroThreshold) {
      frequencySignal.imaginary = 0;
    }

    // Average contribution at this frequency.
    // The 1/N factor is usually moved to the reverse transform (going from frequencies
    //   back to time). This is allowed, though it would be nice to have 1/N in the forward
    //   transform since it gives the actual sizes for the time spikes.
    frequencySignal = frequencySignal.divide(N);

    // Add current frequency signal to the list of compound signals.
    signals[frequency] = frequencySignal;
  }

  return signals;
}
