import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import type UserEntity from '@user/domain/entities/user.entity'

export class UserInMemoryRepository extends BaseInMemoryRepository<UserEntity> implements IUserRepository { }
