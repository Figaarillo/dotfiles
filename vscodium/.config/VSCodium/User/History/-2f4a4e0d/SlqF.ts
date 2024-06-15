import User from '../entities/user.entity'
import type IUserPayload from '../payloads/user.payload'

// eslint-disable-next-line @typescript-eslint/no-extraneous-class
class UserFactory {
  static create(payload: IUserPayload): User {
    const firstName = payload.firstName
    const lastName = payload.lastName
    const phoneNumber = payload.phoneNumber
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
