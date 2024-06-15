import { IUser as User } from '../entities/user/user.interface'
import { Nullable } from '../../domain/nullable'

export interface UserRepository {
  getAll: () => Promise<User[]>
  save: (user: User) => Promise<User>
  getByUsername: (username: string) => Promise<Nullable<User>>
  update: (user: User) => Promise<User>
  delete: (user: User) => Promise<void>
  getById: (id: string) => Promise<Nullable<User>> 
}

