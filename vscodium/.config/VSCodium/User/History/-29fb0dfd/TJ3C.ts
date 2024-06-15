class UserCreatorUserCase {
  readonly #userRepository: UserRepository

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
