import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type UpdateUserPayload from '@user/domain/payloads/update-user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserUpdaterUseCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: UpdateUserPayload): Promise<IUserEntity | null> {
    const userStored: IUserEntity | null = await this.#userRepository.getById(payload.id)

    if (userStored === null) return null

    const userToUpdate: IUserEntity = {
      id: userStored.id,
      createdAt: userStored?.createdAt,
      updatedAt: new Date(),
      firstName: payload.firstName ?? userStored?.firstName,
      lastName: payload.lastName ?? userStored?.lastName,
      phoneNumber: payload.phoneNumber ?? userStored?.phoneNumber,
      birthday: payload.birthday ?? userStored?.birthday
    }

    const userUpdated = await this.#userRepository.update(userToUpdate)

    return userUpdated
  }
}

export default UserUpdaterUseCase
