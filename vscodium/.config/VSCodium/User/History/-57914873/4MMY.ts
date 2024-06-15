import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async run(userId: string): Promise<any> {

  }
}
