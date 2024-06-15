import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import UserEntity from '@user/domain/entities/user.entity'

export class UserInMemoryRepository extends BaseInMemoryRepository<UserEntity> implements IUserRepository { }
