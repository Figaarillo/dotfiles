import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(userId: string): Promise<IUserEntity> {
    const userToDelete: IUserEntity | any = this.#userRepository.getById(userId)

    await this.#userRepository.delete(userToDelete)

    return userToDelete
  }
}

export default UserDeleterUseCase
