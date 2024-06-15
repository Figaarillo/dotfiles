import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import BaseEntity from '@shared/domain/entities/base.entity'

export class UserInMemoryRepository extends BaseInMemoryRepository<IUserEntity extends BaseEntity> implements IUserRepository { }