import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserGetterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(): Promise<IUserEntity[]> {
    const users: IUserEntity[] = await this.#userRepository.getAll()

    return users
  }
}

export default UserGetterUseCase
