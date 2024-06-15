import IBaseRepository from "@shared/infrastructure/repositories/interfaces/base.repository.interface";
import UserEntity from "@user/domain/entities/user.entity";

interface IUserRepository extends IBaseRepository<UserEntity> {}

export default IUserRepository
