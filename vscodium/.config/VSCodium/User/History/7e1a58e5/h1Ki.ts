import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'
import { type FirstName, type LastName, type PhoneNumber, type Birthday } from '../value-objects/user.value-object'

interface IUserEntity extends IBaseEntity, IUserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
}

export default IUserEntity
