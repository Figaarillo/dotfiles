import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

class UserCreatorUserCase {
  readonly #userRepository: IUserRepository

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
