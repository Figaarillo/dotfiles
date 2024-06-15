import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'

export class UserInMemoryRepository extends BaseInMemoryRepository<IUserEntity> implements IUserRepository { }
