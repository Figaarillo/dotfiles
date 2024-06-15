import BaseInMemoryRepository from "@shared/infrastructure/repositories/in-memory/base.in-memory.repository";

export class UserInMemoryRepository extends BaseInMemoryRepository<UserEntity> implements IUserRepository { }
