import type IUserPayload from '@user/domain/payloads/user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserUpdaterUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: IUserPayload): Promise<void> {

  }
}

export default UserUpdaterUserCase
