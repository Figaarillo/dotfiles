import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'
import { FirstName } from '../value-objects/user.value-object'

interface IUserEntity extends IBaseEntity, IUserPayload {
  firstName: FirstName
  lastName: 
  phoneNumber: number
  birthday: string
}

export default IUserEntity
