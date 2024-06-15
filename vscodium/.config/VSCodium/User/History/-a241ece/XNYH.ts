import { type UpdateResult, type DeleteResult } from 'typeorm'
import { BaseService } from '../../config/base.service'
import UserEntity from '../entities/user.entity'
import type UserDTO from '../dtos/user.dto'
import bcrypt from 'bcrypt'

class UserService extends BaseService<UserEntity> {
  constructor() {
    super(UserEntity)
  }

  async create(user: UserEntity): Promise<UserEntity> {
    const newUser = await (await this.execRepository).save(user)

    const hashedPassword = await bcrypt.hash(newUser.password, 10)


    return await (await this.execRepository).save(newUser)
  }

  async delete(id: string): Promise<DeleteResult> {
    return await (await this.execRepository).delete(id)
  }

  async getAll(): Promise<UserEntity[]> {
    return await (await this.execRepository).find()
  }

  async getById(id: string): Promise<UserEntity | null> {
    return await (await this.execRepository).findOneBy({ id })
  }

  async update(id: string, infoUpdate: UserDTO): Promise<UpdateResult> {
    return await (await this.execRepository).update(id, infoUpdate)
  }
}

export default UserService
