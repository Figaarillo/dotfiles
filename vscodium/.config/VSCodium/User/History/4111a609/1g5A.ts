import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUserEntity> implements IUserEntity {
  constructor(props: IUserPayload) {
    super({
      ...props,
      createdAt: new Date(),
      updatedAt: new Date(),
      toPrimitive: function (): IUserPayload {
        throw new Error('Function not implemented.')
      },
      markAsUpdated: function (): void {
        throw new Error('Function not implemented.')
      },
      id: ''
    })
  }
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string

  toPrimitive(): IUserEntity {
    return {
      ...this.data,
      id: this.id,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt
    }
  }
}

export default UserEntity
