import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'
import { FirstName, LastName } from '../value-objects/user.value-object'

interface IUserEntity extends IBaseEntity, IUserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: number
  birthday: string
}

export default IUserEntity
