import User from '../entities/user.entity'
import type IUserPayload from '../payloads/user.payload'
import { FirstName, LastName, PhoneNumber } from '../value-objects/user.value-object'

// eslint-disable-next-line @typescript-eslint/no-extraneous-class
class UserFactory {
  static create(payload: IUserPayload): User {
    const firstName = new FirstName(payload.firstName)
    const lastName = new LastName(payload.lastName)
    const phoneNumber = new PhoneNumber
    const birthday = payload.birthday

    const userPayload = {
      firstName,
      lastName,
      phoneNumber,
      birthday
    }

    return new User(userPayload)
  }
}

export default UserFactory
