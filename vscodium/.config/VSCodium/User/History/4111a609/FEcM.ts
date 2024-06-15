import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUserEntity> implements IUserEntity {
  #firstName: string
  #lastName: string
  #phoneNumber: number
  #birthday: string

  constructor(props: IUserEntity) {
    super(props)
    Object.freeze(this)
    this.#firstName = this.data.firstName
    this.#lastName = this.data.lastName.value
    this.#phoneNumber = this.data.phoneNumber.value
    this.#birthday = this.data.birthday.value
  }

  get firstName(): string {
    return this.#firstName
  }

  // get lastName(): string {
  //   return this.#lastName
  // }

  // get phoneNumber(): number {
  //   return this.#phoneNumber
  // }

  // get birthday(): string {
  //   return this.#birthday
  // }
}

export default UserEntity
