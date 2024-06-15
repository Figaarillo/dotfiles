/* eslint-disable no-console */
import UserCreatorUserCase from '@user/application/use-cases/creators/user.creator.usecase'
import UserGetterUseCase from '@user/application/use-cases/getters/user.getter.usecase'
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

const test = async (): Promise<void> => {
  const repository = new UserInMemoryRepository()
  const creatorUseCase = new UserCreatorUserCase(repository)
  const deleterUseCase = new UserDeleterUserCase(repository)
  await creatorUseCase.execute(userPayload)
  const userToDelete = await creatorUseCase.execute(userPayload2)
  await deleterUseCase.
  userToDelete.id
  await creatorUseCase.execute(userPayload3)
  await creatorUseCase.execute(userPayload4)
  const getterUseCase = new UserGetterUseCase(repository)
  const getUser = await getterUseCase.execute()

  console.log(getUser)
}

test()
