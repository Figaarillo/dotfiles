/* eslint-disable no-console */
import UserCreatorUseCase from '@user/application/use-cases/creators/user.creator.usecase'
import UserDeleterUseCase from '@user/application/use-cases/deleters/user.deleter.usecase'
import UserGetterUseCase from '@user/application/use-cases/getters/user.getter.usecase'
import UserUpdaterUseCase from '@user/application/use-cases/updaters/user.updater.usecase'
import type UpdateUserPayload from '@user/domain/payloads/update-user.payload'
import type IUserPayload from '@user/domain/payloads/user.payload'
import { UserInMemoryRepository } from '@user/infrastructure/repositories/user-in-memory.repository'

const userPayload: IUserPayload = {
  firstName: 'Axel',
  lastName: 'Leonardi',
  phoneNumber: 12342134,
  birthday: '22-10-1998'
}
const userPayload2: IUserPayload = {
  firstName: 'Name2',
  lastName: 'lastName2',
  phoneNumber: 12342134,
  birthday: '22-10-1998'
}
const userPayload3: IUserPayload = {
  firstName: 'firtsName3',
  lastName: 'lastName3',
  phoneNumber: 12342134,
  birthday: '22-10-1998'
}
const userPayload4: IUserPayload = {
  firstName: 'firstName4',
  lastName: 'lastName4',
  phoneNumber: 12342134,
  birthday: '22-10-1998'
}

;(async (): Promise<void> => {
  const repository = new UserInMemoryRepository()
  const creatorUseCase = new UserCreatorUseCase(repository)
  const deleterUseCase = new UserDeleterUseCase(repository)
  const updaterUseCase = new UserUpdaterUseCase(repository)

  await creatorUseCase.execute(userPayload)

  const userToDelete = await creatorUseCase.execute(userPayload2)
  await deleterUseCase.execute(userToDelete.id)

  const userToUpdate = await creatorUseCase.execute(userPayload3)
  const newPayload: UpdateUserPayload = {
    id: userToUpdate.id,
    firstName: 'new name',
    lastName: 'new last name',
    phoneNumber: 134234234,
    birthday: '22-10-1998'
  }
  await updaterUseCase.execute(newPayload)

  await creatorUseCase.execute(userPayload4)
  const getterUseCase = new UserGetterUseCase(repository)
  const getUser = await getterUseCase.execute()

  console.log(getUser)
})()
