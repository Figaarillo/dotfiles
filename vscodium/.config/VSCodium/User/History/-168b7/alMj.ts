import type IUserPayload from '@user/domain/payloads/user.payload'

class UserUpdaterUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: IUserPayload): Promise<void> {

  }
}

export default UserUpdaterUserCase
