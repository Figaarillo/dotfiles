import type UserEntity from '@user/domain/entities/user.entity'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async run(userId: string): Promise<any> {
    type NewType = IUserEntity

    const userToDelete: NewType = this.#userRepository.getById(userId)

    await this.#userRepository.delete(userToDelete)

    return userToDelete
  }
}

export default UserDeleterUseCase
