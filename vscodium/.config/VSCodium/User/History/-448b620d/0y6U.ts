import { User } from '../../domain/entities/user/user.entity'
import { UserRepository } from '../../domain/repositories/user.repository'
import { UserAlreadyExistsException } from '../../domain/exeptions/user-already-exist.exception'
import { ExistUserByUsername } from '../../domain/services/exist-user-by-user-name.service'
import { UuidGenerator } from '../../domain/utils/uuid-generator.util'
import { UserIsNotAnAdultException } from '../../domain/exeptions/user-is-not-an-adult.exception'
import {
  UserAge,
  UserId,
  UserName,
  UserUsername,
} from '../../domain/entities/user/value-objects'
import { IUser } from 'user/domain/entities/user/user.interface'

interface UserInput {
  name: string
  age: number
  username: string
}

export class UserCreatorUseCase {
  private readonly _userRepository: UserRepository
  // Representa un servicio de dominio que representa una accion que se ejecuta reiteradas veces
  private readonly _existUserByUsername: ExistUserByUsername
  private readonly _uuidGenerator: UuidGenerator

  constructor(userRepository: UserRepository, uuidGenerator: UuidGenerator) {
    this._userRepository = userRepository
    this._existUserByUsername = new ExistUserByUsername(userRepository)
    this._uuidGenerator = uuidGenerator
  }

  /**
   * create new user if user does not exist
   * @param body
   * @returns user crated
   */
  async run(params: UserInput): Promise<IUser> {
    const user = new User({
      id: new UserId(this._uuidGenerator.generate()),
      name: new UserName(params.name),
      username: new UserUsername(params.username),
      age: new UserAge(params.age),
    })

    const existUser: boolean = await this._existUserByUsername.run(
      user.username._value
    )

    if (existUser) throw new UserAlreadyExistsException()

    const isAnAdult = user.isAdult()
    if (!isAnAdult) throw new UserIsNotAnAdultException()

    const userCreated: IUser = await this._userRepository.save(user)

    return userCreated
  }
}
