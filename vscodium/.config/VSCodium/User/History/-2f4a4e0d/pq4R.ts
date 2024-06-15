import User from '../entities/user.entity'
import IUserEntity from '../interfaces/user.entity.interface'
import type IUserPayload from '../payloads/user.payload'
import { Birthday, FirstName, LastName, PhoneNumber } from '../value-objects/user.value-object'

// eslint-disable-next-line @typescript-eslint/no-extraneous-class
class UserFactory {
  static create(payload: IUserPayload): User {
    const firstName = new FirstName(payload.firstName)
    const lastName = new LastName(payload.lastName)
    const phoneNumber = new PhoneNumber(payload.phoneNumber)
    const birthday = new Birthday(payload.birthday)

    const userPayload: IUserEntity = {
      firstName,
      lastName,
      phoneNumber,
      birthday,
      id: '',
      createdAt: undefined,
      updatedAt: undefined
    }

    return new User(userPayload)
  }
}

export default UserFactory
