import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'
import { FirstName, LastName, PhoneNumber } from '../value-objects/user.value-object'

interface IUserEntity extends IBaseEntity, IUserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: string
}

export default IUserEntity
