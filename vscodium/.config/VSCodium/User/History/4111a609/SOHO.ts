import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUserPayload> implements IUserEntity {
  private readonly _firstName: string
  private readonly _lastName: string
  private readonly _phoneNumber: number
  private readonly _birthday: string

  constructor(props: IUserPayload) {
    super(props)
    this._firstName = this.data.firstName
    this._lastName = this.data.firstName
    this._phoneNumber = this.data.phoneNumber
    this._birthday = this.data.firstName
  }

  get firstName(): string {
    return this._firstName
  }

  get lastName(): string {
    return this._lastName
  }

  get phoneNumber(): number {
    return this._phoneNumber
  }

  get birthday(): string {
    return this._birthday
  }
}

export default UserEntity
