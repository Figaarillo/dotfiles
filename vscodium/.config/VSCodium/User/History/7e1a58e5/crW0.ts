import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import {
  type LastName,
  type FirstName,
  type PhoneNumber,
  type Birthday
} from '../value-objects/user.value-object'
// import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity,  {
}

export default IUserEntity
