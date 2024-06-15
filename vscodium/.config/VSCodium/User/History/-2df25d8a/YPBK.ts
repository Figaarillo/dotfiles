import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'

class UserInMemoryRepository extends BaseInMemoryRepository implements IUserRepository<IUserEntity> {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor() {
    super()
  }
}
