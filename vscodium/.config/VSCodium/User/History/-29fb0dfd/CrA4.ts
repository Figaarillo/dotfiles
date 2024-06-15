import UserFactory from '@user/domain/factories/user.factory'
import type IUserPayload from '@user/domain/payloads/user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(userPayload: IUserPayload): Promise<any> {
    const userCreated = UserFactory.create(userPayload)

    this.#userRepository.save(userCreated)

    return userCreated
  }
}

export default UserCreatorUseCase
