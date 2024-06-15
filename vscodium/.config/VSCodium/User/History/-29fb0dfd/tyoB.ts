import UserFactory from '@user/domain/factories/user.factory'
import type IUserPayload from '@user/domain/payloads/user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  execute(userPayload: IUserPayload) {
    const userToCreate = UserFactory.create(userPayload)
  }
}

export default UserCreatorUserCase
