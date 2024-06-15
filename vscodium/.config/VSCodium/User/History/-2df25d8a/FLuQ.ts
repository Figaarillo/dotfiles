import { Nullable } from '@shared/domain/types/nullable.type'
import UserEntity from '@user/domain/entities/user.entity'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'

class UserInMemoryRepository extends BaseInMemoryRepository implements IUserRepository {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor() {
    super()
  }
  getAll: () => Promise<UserEntity[]>
  save: (entity: UserEntity) => Promise<UserEntity>
  getBy: (property: string) => Promise<Nullable<UserEntity>>
  update: (entity: UserEntity) => Promise<UserEntity>
  delete: (entity: UserEntity) => Promise<void>
  getById: (id: string) => Promise<Nullable<UserEntity>>
}
