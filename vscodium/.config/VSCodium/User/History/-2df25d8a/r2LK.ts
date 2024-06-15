import { Nullable } from '@shared/domain/types/nullable.type';
import UserEntity from '@user/domain/entities/user.entity';
import type IUserRepository from '../interfaces/user.repository.interface'

class UserInMemoryRepository implements IUserRepository {
	getAll: () => Promise<UserEntity[]>;
	save: (user: UserEntity) => Promise<UserEntity>;
	getBy: (username: string) => Promise<Nullable<UserEntity>>;
	update: (user: UserEntity) => Promise<UserEntity>;
	delete: (user: UserEntity) => Promise<void>;
	getById: (id: string) => Promise<Nullable<UserEntity>>;

}
