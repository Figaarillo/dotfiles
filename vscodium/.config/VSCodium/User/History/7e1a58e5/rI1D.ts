import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import {
  type LastName,
  type FirstName,
  type PhoneNumber,
  type Birthday
} from '../value-objects/user.value-object'
import type UserPayload from '../payloads/user.payload'
// import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity, UserPayload {
}

export default IUserEntity
