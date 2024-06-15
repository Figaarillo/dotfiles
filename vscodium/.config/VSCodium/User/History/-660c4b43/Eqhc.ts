import type IBaseRepository from '@shared/infrastructure/interfaces/base.repository.interface'
import type UserEntity from '@user/domain/entities/user.entity'
import IUserEntity from '@user/domain/interfaces/user.entity.interface'

interface IUserRepository extends IBaseRepository<IUserEntity> {}

export default IUserRepository
