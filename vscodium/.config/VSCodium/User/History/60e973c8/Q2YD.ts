import { User } from '../../../domain/entities/user.entity'
import { UserGetterUseCase } from '../../../application/use-cases/user-getter.usecase'
import { UserCreatorUseCase } from '../../../application/use-cases/user-cretor.usecase'
import { UserUpdaterUseCase } from '../../../application/use-cases/user-updater.usecase'
import { UserDeleterUseCase } from '../../../application/use-cases/user-deleter.usecase'
import { InMemoryUserRepository } from '../../implementations/in-memory/in-memory-user-repository'
  ;import { IUser } from 'user/domain/entities/user/user.interface'
 (async () => {
    const inMemoryUserRepository = new InMemoryUserRepository()

    // Creating user
    const userCreatorUseCase = new UserCreatorUseCase(inMemoryUserRepository)
    const userToCreate: IUser = {
      name: new UserName('user'),
      age: 17,
      username: 'username',
      id: '1',
    }
    await userCreatorUseCase.run(userToCreate)

    // Getting users
    const userGetterUseCase = new UserGetterUseCase(inMemoryUserRepository)
    const userReturned = await userGetterUseCase.run()
    console.log(userReturned)

    // Updating users
    const userUpdaterUseCase = new UserUpdaterUseCase(inMemoryUserRepository)
    await userUpdaterUseCase.run({
      id: '1',
      username: 'luci',
    })

    const userReturned2 = await userGetterUseCase.run()
    console.log(userReturned2)

    // Deleting user
    const userDeleterUseCase = new UserDeleterUseCase(inMemoryUserRepository)
    await userDeleterUseCase.run('1')

    const userReturned3 = await userGetterUseCase.run()
    console.log(userReturned3)
  })()
