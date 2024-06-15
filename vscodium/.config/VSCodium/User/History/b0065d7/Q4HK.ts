import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'

export class UserInMemoryRepository
  extends BaseInMemoryRepository<IUserEntity>
  implements IUserRepository {}
