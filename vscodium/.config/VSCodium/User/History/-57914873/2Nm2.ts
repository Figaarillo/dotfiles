import type UserEntity from '@user/domain/entities/user.entity'
import IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async run(userId: string): Promise<any> {
    const userToDelete: IUserEntity = this.#userRepository.getById(userId)

    await this.#userRepository.delete(userToDelete)

    return userToDelete
  }
}

export default UserDeleterUseCase
