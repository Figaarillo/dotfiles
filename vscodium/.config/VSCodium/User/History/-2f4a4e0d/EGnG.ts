import User from '../entities/user.entity'
import type IUserPayload from '../payloads/user.payload'
import { Birthday, FirstName, LastName, PhoneNumber } from '../value-objects/user.value-object'

// eslint-disable-next-line @typescript-eslint/no-extraneous-class
class UserFactory {
  static create(payload: IUserPayload): User {
    const firstName = new FirstName(payload.firstName)
    const lastName = new LastName(payload.lastName)
    const phoneNumber = new PhoneNumber(payload.phoneNumber)
    const birthday = new Birthday(payload.birthday)

    const userPayload: IUser = {
      firstName,
      lastName,
      phoneNumber,
      birthday
    }

    return new User(userPayload)
  }
}

export default UserFactory
