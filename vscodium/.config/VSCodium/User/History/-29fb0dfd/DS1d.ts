class UserCreatorUserCase {
  readonly #userRepository: UserInMemoryRepository

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
