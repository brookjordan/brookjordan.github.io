import radianToDegree from "./radianToDegree";

interface ComplexNumberInitiator {
  real: number;
  imaginary?: number;
}

export default class ComplexNumber {
  #real: number;
  #imaginary: number;

  /**
   * Convert real numbers to complex number.
   * In case if complex number is provided then lefts it as is.
   */
  static toComplexNumber(
    number:
      | ComplexNumber
      | ComplexNumberInitiator
      | [number]
      | [number, number]
      | number
  ) {
    if (number instanceof ComplexNumber) {
      return number;
    }

    return new ComplexNumber(number);
  }

  get real() {
    return this.#real;
  }

  get imaginary() {
    return this.#imaginary;
  }
  set real(newValue: number) {
    this.#real = newValue;
  }

  set imaginary(newValue: number) {
    this.#imaginary = newValue;
  }

  get radius() {
    return Math.sqrt(this.#real ** 2 + this.#imaginary ** 2);
  }

  get phase() {
    let phase = Math.atan(Math.abs(this.#imaginary) / Math.abs(this.#real));

    if (this.#real < 0 && this.#imaginary > 0) {
      phase = Math.PI - phase;
    } else if (this.#real < 0 && this.#imaginary < 0) {
      phase = -(Math.PI - phase);
    } else if (this.#real > 0 && this.#imaginary < 0) {
      phase = -phase;
    } else if (this.#real === 0 && this.#imaginary > 0) {
      phase = Math.PI / 2;
    } else if (this.#real === 0 && this.#imaginary < 0) {
      phase = -Math.PI / 2;
    } else if (this.#real < 0 && this.#imaginary === 0) {
      phase = Math.PI;
    } else if (this.#real > 0 && this.#imaginary === 0) {
      phase = 0;
    } else if (this.#real === 0 && this.#imaginary === 0) {
      phase = null;
    }

    // if (!inRadians) {
    //   phase = radianToDegree(phase);
    // }

    return phase;
  }

  constructor(
    number: number | [number] | [number, number] | ComplexNumberInitiator
  ) {
    if (typeof number === "number") {
      this.#real = number;
      this.#imaginary = 0;
    } else if (Array.isArray(number)) {
      this.#real = number[0];
      this.#imaginary = number[1] || 0;
    } else {
      this.#real = number.real;
      this.#imaginary = number.imaginary || 0;
    }
  }

  add(addend: ComplexNumber | number) {
    const complexAddend = ComplexNumber.toComplexNumber(addend);

    return new ComplexNumber({
      real: this.#real + complexAddend.#real,
      imaginary: this.#imaginary + complexAddend.#imaginary,
    });
  }

  subtract(subtrahend: ComplexNumber | number) {
    const complexSubtrahend = ComplexNumber.toComplexNumber(subtrahend);

    return new ComplexNumber({
      real: this.#real - complexSubtrahend.#real,
      imaginary: this.#imaginary - complexSubtrahend.#imaginary,
    });
  }

  multiply(multiplicand: ComplexNumber | number) {
    const complexMultiplicand = ComplexNumber.toComplexNumber(multiplicand);

    return new ComplexNumber({
      real:
        this.#real * complexMultiplicand.#real -
        this.#imaginary * complexMultiplicand.#imaginary,
      imaginary:
        this.#real * complexMultiplicand.#imaginary +
        this.#imaginary * complexMultiplicand.#real,
    });
  }

  divide(divider: ComplexNumber | number) {
    const complexDivider = ComplexNumber.toComplexNumber(divider);

    // Get divider conjugate.
    const dividerConjugate = this.conjugate(complexDivider);

    // Multiply dividend by divider's conjugate.
    const finalDivident = this.multiply(dividerConjugate);

    // Calculating final divider using formula (a + bi)(a − bi) = a^2 + b^2
    const finalDivider =
      complexDivider.#real ** 2 + complexDivider.#imaginary ** 2;

    return new ComplexNumber({
      real: finalDivident.#real / finalDivider,
      imaginary: finalDivident.#imaginary / finalDivider,
    });
  }

  conjugate(number: ComplexNumber | number) {
    const complexNumber = ComplexNumber.toComplexNumber(number);

    return new ComplexNumber({
      real: complexNumber.#real,
      imaginary: -1 * complexNumber.#imaginary,
    });
  }
}
