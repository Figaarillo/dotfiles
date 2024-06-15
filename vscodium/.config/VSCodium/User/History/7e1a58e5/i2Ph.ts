import type IBaseEntity from '@shared/domain/entities/base.interface'
import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity<IUserPayload>, IUserPayload {}
