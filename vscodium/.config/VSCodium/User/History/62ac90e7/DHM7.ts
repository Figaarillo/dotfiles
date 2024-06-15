import { EntityRoot } from '../entity-root'
import { AgeNotProvided } from './exceptions'
import { IUser } from './user.interface'
import { UserId, UserName, UserUsername, UserAge } from './value-objects'

export interface PrimitiveData {
  id: string
  name?: string
  username?: string
  age?: number
}

export class User extends EntityRoot<User, PrimitiveData> implements IUser{
  readonly id: UserId
  readonly name: UserName
  readonly username: UserUsername
  readonly age?: UserAge

  constructor({
    id,
    name,
    username,
    age,
  }: {
    id: UserId
    name: UserName
    username: UserUsername
    age?: UserAge
  }) {
    super()
    this.id = id
    this.name = name
    this.username = username
    this.age = age
  }

  static create(
    id: UserId,
    name: UserName,
    username: UserUsername,
    age?: UserAge
  ) {
    const user = new User({
      id,
      name,
      username,
      age,
    })

    return user
  }

  static fromPrimitives(plainData: {
    id: string
    name: string
    username: string
    age?: number
  }): User {
    return new User({
      id: new UserId(plainData.id),
      name: new UserName(plainData.name),
      username: new UserUsername(plainData.username),
      age: new UserAge(plainData.age),
    })
  }

  toPrimitive(): PrimitiveData {
    return {
      id: this.id._value,
      name: this.name._value,
      username: this.username._value,
      age: this.age?._value,
    }
  }

  isAdult(age?: number): boolean {
    if (age === undefined) {
      if (this.age?._value === undefined) {
        throw new AgeNotProvided()
      } else {
        return this.age._value >= 18
      }
    } else {
      return age >= 18
    }
  }
}
