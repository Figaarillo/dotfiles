import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  execute()
}

export default UserCreatorUserCase
