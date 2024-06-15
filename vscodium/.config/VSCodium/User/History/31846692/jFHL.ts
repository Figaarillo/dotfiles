export class FirstName {
  readonly #value: string

  constructor(value: string) {
    this.#value = value
  }

  get value(): string {
    return this.#value
  }

  getName(): string {
    return this.#value
  }
}

export class LastName {
  readonly #value: string

  constructor(value: string) {
    this.#value = value
  }

  get value(): string {
    return this.#value
  }
}

export class PhoneNumber {
  readonly #value: number

  constructor(value: number) {
    this.#value = value
  }

  get value(): number {
    return this.#value
  }
}

export class Birthday {
  readonly #value: string

  constructor(value: string) {
    this.#value = value
  }

  get value(): string {
    return this.#value
  }
}
