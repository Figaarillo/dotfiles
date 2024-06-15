import IBaseEntity from '@shared/domain/interfaces/base.entity.interface'
import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity<IUserPayload>, IUserPayload {}

export default IUserEntity
