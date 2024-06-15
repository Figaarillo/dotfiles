import BaseEntity from '@shared/domain/entities/base.entity'
import type IUserPayload from '../payloads/user.payload'
import type IUserEntity from '../interfaces/user.entity.interface'

class UserEntity extends BaseEntity<IUserPayload> implements IUserEntity {
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string

  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor(props: IUserPayload) {
    super(props)
    this.firstName = this.data.firstName
    this.lastName = this.data.lastName
    this.phoneNumber = this.data.phoneNumber
    this.birthday = this.data.birthday
  }

  toPrimitive(): Omit<IUserEntity, 'toPrimitive' | 'markAsUpdated'> {
    return {
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      phoneNumber: this.phoneNumber,
      birthday: this.birthday,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt
    }
  }
}

export default UserEntity
