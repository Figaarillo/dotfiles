import BaseInMemoryRepository from "@shared/infrastructure/repositories/in-memory/base.in-memory.repository";
import UserEntity from "@user/domain/entities/user.entity";
import IUserRepository from "@user/infrastructure/interfaces/user.repository.interface";

export class UserInMemoryRepository extends BaseInMemoryRepository<UserEntity> implements IUserRepository { }
