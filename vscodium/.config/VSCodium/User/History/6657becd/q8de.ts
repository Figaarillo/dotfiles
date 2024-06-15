import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserGetterUseCase {
  readonly #userRepository: IUserRepository
}

export default UserGetterUseCase
