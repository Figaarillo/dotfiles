export class FirstName {
  readonly #value: string

  constructor(value: string) {
    this.#value = value
  }

  get value() { return this.#value }
}
