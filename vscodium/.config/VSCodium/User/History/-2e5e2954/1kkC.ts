import type IBaseRepository from '@shared/infrastructure/interfaces/base.repository.interface'
import type UserEntity from '@user/domain/entities/user.entity'

interface IUserRepository extends IBaseRepository<UserEntity> {}

export default IUserRepository
