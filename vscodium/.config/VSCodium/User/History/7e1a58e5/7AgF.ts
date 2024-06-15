import type IBaseEntity from '@shared/domain/entities/base.interface'
import type IUserPayload from '../payloads/user.payload'

type NewType = IBaseEntity

interface IUserEntity extends NewType, IUserPayload {}
