import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'
import {
  FirstName,
  Birthday,
  LastName,
  PhoneNumber
} from '../value-objects/user.value-object'

class UserEntity extends BaseEntity<IUserPayload> implements IUserEntity {
  private readonly _firstName: FirstName
  private readonly _lastName: LastName
  private readonly _phoneNumber: PhoneNumber
  private readonly _birthday: Birthday

  constructor(props: IUserPayload) {
    super(props)
    this._firstName = this.data.firstName
    this._lastName = this.data.firstName
    this._phoneNumber = this.data.phoneNumber
    this._birthday = this.data.firstName
  }

  get firstName(): FirstName {
    return this._firstName
  }

  get lastName(): LastName {
    return this._lastName
  }

  get phoneNumber(): PhoneNumber {
    return this._phoneNumber
  }

  get birthday(): Birthday {
    return this._birthday
  }
}

export default UserEntity
