import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserGetterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async exucute(): Promise<IUserEntity[]> {

  }
}

export default UserGetterUseCase
