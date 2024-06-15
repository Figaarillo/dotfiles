import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'
import { type FirstName, type LastName, type PhoneNumber, type Birthday } from '../value-objects/user.value-object'

class UserEntity extends BaseEntity<IUserPayload> implements IUserEntity {
  // #firstName: string
  // #lastName: string
  // #phoneNumber: number
  // #birthday: string
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string

  constructor(props: IUserPayload) {
    super(props)
    Object.freeze(this)
    this.#firstName = this.data.firstName.value
    this.#lastName = this.data.lastName.value
    this.#phoneNumber = this.data.phoneNumber.value
    this.#birthday = this.data.birthday.value
  }


  getFirstName(): string {
    return this.#firstName
  }

  getLastName(): string {
    return this.#lastName
  }

  getPhoneNumber(): number {
    return this.#phoneNumber
  }

  getBirthday(): string {
    return this.#birthday
  }
}

export default UserEntity
