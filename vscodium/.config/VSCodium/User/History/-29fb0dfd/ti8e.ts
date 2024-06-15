import { UserInMemoryRepository } from "@user/infrastructure/repositories/user-in-memory.repository"

class UserCreatorUserCase {
  readonly #userRepository: UserInMemoryRepository

  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default UserCreatorUserCase
