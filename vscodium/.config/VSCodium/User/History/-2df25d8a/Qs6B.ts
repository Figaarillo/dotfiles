import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import IBaseEntityData from '@shared/domain/interface/base-data.entity.interface'

export class UserInMemoryRepository extends BaseInMemoryRepository<IUserEntity extends IBaseEntityData> implements IUserRepository { }