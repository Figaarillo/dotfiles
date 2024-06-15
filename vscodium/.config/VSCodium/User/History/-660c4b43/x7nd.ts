import type IBaseRepository from '@shared/infrastructure/interfaces/base.repository.interface'
import type IUserEntity from '@user/domain/interfaces/user.entity.interface'

interface IUserRepository extends IBaseRepository<IUserEntity> {}

export default IUserRepository
