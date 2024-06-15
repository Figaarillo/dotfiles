import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserDeleterUseCase {
  readonly #userRepository: IUserRepository
}
