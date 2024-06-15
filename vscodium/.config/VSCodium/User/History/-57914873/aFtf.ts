import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(userId: string): Promise<IUserEntity | null> {
    const userToDelete: IUserEntity | null = await this.#userRepository.getById(userId)

    if (userToDelete === null) {
      return null
    }
    await this.#userRepository.delete(userToDelete)

    return userToDelete
  }
}

export default UserDeleterUseCase
