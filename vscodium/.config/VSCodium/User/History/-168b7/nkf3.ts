import type UpdateUserPayload from '@user/domain/payloads/update-user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserUpdaterUserCase {
  readonly #userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.#userRepository = userRepository
  }

  async execute(payload: UpdateUserPayload): Promise<void> {
    const userToUpdate = await this.#userRepository.getById(payload.id)

    userToUpdate?.firstName = payload.firstName
    userToUpdate?.lastName = payload.lastName
    userToUpdate?.birthday = payload.birthday
    userToUpdate.phoneNumber = payload.phoneNumber
  }
}

export default UserUpdaterUserCase
