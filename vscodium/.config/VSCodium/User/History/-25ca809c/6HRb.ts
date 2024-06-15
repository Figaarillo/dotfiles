import { User } from 'user/domain/entities/user/user.entity'
import { UserRepository } from '../../../domain/repositories/user.repository'

export class InMemoryUserRepository implements UserRepository {
  private userData: User[] = []

  async getAll(): Promise<User[]> {
    const users = this.userData as User[]
    return users
  }

  async save(user: User): Promise<User> {
    this.userData.push(user)
    return user
  }

  async getByUsername(username: string): Promise<User | null> {
    const userFound = this.userData.find(user => user.username._value === username)

    if (userFound === undefined) return null

    return userFound
  }

  /**
   * Get an updated user and save it
   * @param user updated user data
   * @returns updated user list
   */
  async update(user: User): Promise<User> {
    // Se obtienen todos los usuarios distinos al que se vaya a actualizar
    const users: User[] = this.userData.filter(
      userStored => userStored.id !== user.id
    )

    users.push(user)

    this.userData = users

    return user
  }

  async delete(user: User): Promise<void> {
    const users = this.userData.filter(userStored => userStored.id !== user.id)

    this.userData = users
  }

  async getById(id: string): Promise<User | null> {
    const userFound = this.userData.find(user => user.id === id)

    if (userFound === undefined) return null

    return userFound
  }
}
