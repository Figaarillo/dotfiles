import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUserPayload> implements IUserEntity {
  #firstName: string
  #lastName: string
  #phoneNumber: number
  #birthday: string

  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor(props: IUserPayload) {
    super(props)
    Object.freeze(this)
    this.#firstName = this.data.firstName
    this.#lastName = this.data.lastName
    this.#phoneNumber = this.data.phoneNumber
    this.#birthday = this.data.birthday
  }

  get firstName(): string {
    return this.#firstName
  }

  get lastName(): string {
    return this.#lastName
  }

  get phoneNumber(): number {
    return this.#phoneNumber
  }

  get birthday(): string {
    return this.#birthday
  }
}

export default UserEntity
