class UserCreatorUserCase {
  readonly #userRepository: IUser

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
