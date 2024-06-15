class UserCreatorUserCase {
  readonly #userReposi

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
