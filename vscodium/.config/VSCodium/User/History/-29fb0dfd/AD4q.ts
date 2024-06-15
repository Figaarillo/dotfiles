import type UserEntity from '@user/domain/entities/user.entity'
import CreateUserFactory from '@user/domain/factories/create-user.factory'
import type IUserPayload from '@user/domain/payloads/user.payload'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUseCase {
  private readonly userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.userRepository = userRepository
  }

  async execute(userPayload: IUserPayload): Promise<Primitives<IUserEntity>> {
    const userCreated = await this.userService.create(userPayload)

    return entityToPrimitive(userCreated)
  }
}

export default UserCreatorUseCase
