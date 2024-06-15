import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'

class UserInMemoryRepository extends BaseInMemoryRepository implements IUserRepository {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor() {
    super()
  }
}
