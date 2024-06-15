import type UserEntity from '@user/domain/entities/user.entity'

interface IUserRepository extends IUserRepository<UserEntity> {}

export default IUserRepository
