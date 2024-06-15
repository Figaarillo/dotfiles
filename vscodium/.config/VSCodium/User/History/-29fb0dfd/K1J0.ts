import { type Primitives } from '@shared/domain/utilities/primitives'
import { entityToPrimitive } from '@shared/utils/entity-to-primitive'
import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserPayload from '@user/domain/payloads/user.payload'
import UserService from '@user/domain/services/user.service'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUseCase {
  private readonly userRepository: IUserRepository
  private readonly userService: UserService

  constructor(userRepository: IUserRepository) {
    this.userRepository = userRepository
  }

  async execute(userPayload: IUserPayload): Promise<Primitives<IUserEntity>> {
    const userCreated = await this.userService.create(userPayload)

    return entityToPrimitive(userCreated)
  }
}

export default UserCreatorUseCase
