import type IBaseEntity from '@shared/domain/interface/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity<IUserPayload>, IUserPayload {}

export default IUserEntity
