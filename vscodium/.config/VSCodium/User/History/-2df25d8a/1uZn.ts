import type IUserEntity from '@user/domain/interfaces/user.entity.interface'
import type IUserRepository from '../interfaces/user.repository.interface'
import BaseInMemoryRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import IBaseEntityData from '@shared/domain/interface/base-data.entity.interface'

type NewType = BaseInMemoryRepository<IUserEntity extends IBaseEntityData ? : >

export class UserInMemoryRepository extends NewType implements IUserRepository { }