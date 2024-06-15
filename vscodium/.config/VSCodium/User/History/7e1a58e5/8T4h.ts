import type IUserPayload from '../payloads/user.payload'

interface IUserEntity extends IBaseEntity<IUserPayload>, IUserPayload {}

export default IUserEntity
