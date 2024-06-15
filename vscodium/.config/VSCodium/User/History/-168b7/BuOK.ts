import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type UpdateUserPayload from '@user/domain/payloads/update-user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserUpdaterUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: UpdateUserPayload): Promise<IUserEntity> {
    const userToUpdate: IUserEntity | null = await this.#userRepository.getById(payload.id)

    if (userToUpdate === null) return null
    
    const userUpdated = await this.#userRepository.update(userToUpdate)

    return userUpdated
  }
}

export default UserUpdaterUserCase
