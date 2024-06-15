import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'
import {
  type FirstName,
  type Birthday,
  type LastName,
  type PhoneNumber
} from '../value-objects/user.value-object'

class UserEntity extends BaseEntity<IUserEntity> implements IUserEntity {
  private readonly _firstName: FirstName
  private readonly _lastName: LastName
  private readonly _phoneNumber: PhoneNumber
  private readonly _birthday: Birthday

  constructor(props: IUserEntity) {
    super(props)
    this._firstName = this.data.firstName
    this._lastName = this.data.lastName
    this._phoneNumber = this.data.phoneNumber
    this._birthday = this.data.birthday
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
