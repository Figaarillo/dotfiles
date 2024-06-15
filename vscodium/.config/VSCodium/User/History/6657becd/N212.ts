import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserGetterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  execute(): IUserEntity[] {
    const users: IUserEntity[] = this.#userRepository.getAll()

    return users
  }
}

export default UserGetterUseCase
