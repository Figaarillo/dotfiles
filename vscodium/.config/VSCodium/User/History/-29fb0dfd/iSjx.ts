import UserFactory from '@user/domain/factories/user.factory'
import type IUserPayload from '@user/domain/payloads/user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  execute(userPayload: IUserPayload) {
    const userCreated = UserFactory.create(userPayload)

    return userCreated
  }
}

export default UserCreatorUserCase
