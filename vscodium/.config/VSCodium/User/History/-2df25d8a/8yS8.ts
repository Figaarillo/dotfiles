import BaseRepository from '@shared/infrastructure/repositories/in-memory/base.in-memory.repository'
import type IUserRepository from '../interfaces/user.repository.interface'

class UserInMemoryRepository extends UserInMemoryRepository implements IUserRepository {}
