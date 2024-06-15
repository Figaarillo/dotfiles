class UserUpdaterUserCase {
  readonly #userRepository: UserRepository

  constructor(userRepository: UserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: IUserPayload) {

  }
}

export default UserUpdaterUserCase
