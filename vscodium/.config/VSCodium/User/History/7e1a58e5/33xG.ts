import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import { type FirstName, type LastName, type PhoneNumber, type Birthday } from '../value-objects/user.value-object'

interface IUserEntity extends IBaseEntity {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
}

export default IUserEntity
