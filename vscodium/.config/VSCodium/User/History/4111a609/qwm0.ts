import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUser> implements IUserEntity {
  constructor(props: IUserPayload) {
    super({
      ...props,
      createdAt: new Date(),
      updatedAt: new Date()
    })
  }

  toPrimitive(): IUser {
    return {
      ...this.data,
      id: this.id,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt
    }
  }
}

export default UserEntity
