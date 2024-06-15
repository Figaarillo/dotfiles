import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'

  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string
interface IUserEntity extends IBaseEntity, IUserPayload {}

export default IUserEntity
