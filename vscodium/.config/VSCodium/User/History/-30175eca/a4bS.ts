import type IUserRepository from '@user/infrastructure/interfaces/user.repository.interface'
import CreateUserFactory from '../factories/create-user.factory'
import type IUserPayload from '../payloads/user.payload'
import { Birthday, FirstName, LastName, PhoneNumber } from '../value-objects/user.value-object'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserService {
  private readonly userRepository: IUserRepository

  constructor(userRepository: IUserRepository) {
    this.userRepository = userRepository
  }

  async create(userPayload: IUserPayload): Promise<IUserEntity> {
    const userCreated = CreateUserFactory.create(userPayload)

    this.userRepository.save(userCreated)

    return userCreated
  }

  async delete(userEntity: IUserEntity): Promise<void> {
    await this.userRepository.delete(userEntity)
  }

  async getOneById(id: string): Promise<IUserEntity | null> {
    const userStored = await this.userRepository.getBy(id)

    if (userStored === null) {
      return null
    }

    return userStored
  }

  async getAll(): Promise<IUserEntity[]> {
    const usersStored = await this.userRepository.getAll()

    return usersStored
  }

  async hello(name: string): void {
    const GRETTINGS: string = 'Hello, World!'; 

    console.log(GRETTINGS, name)
  }

  async update(payload: IUserPayload, userStored: IUserEntity): Promise<IUserEntity> {
    const userToUpdate = {
      id: userStored.id,
      createdAt: userStored?.createdAt,
      updatedAt: new Date(),
      firstName: new FirstName(payload.firstName) ?? userStored?.firstName,
      lastName: new LastName(payload.lastName) ?? userStored?.lastName,
      phoneNumber: new PhoneNumber(payload.phoneNumber) ?? userStored?.phoneNumber,
      birthday: new Birthday(payload.birthday) ?? userStored?.birthday
    }

    const userUpdated = await this.userRepository.update(userToUpdate)

    return userUpdated
  }
}

export default UserService