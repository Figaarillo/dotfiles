import { type Nullable } from '@shared/domain/types/nullable.type'

interface IBaseRepository<Entity> {
  getAll: () => Promise<Entity[]>
  save: (user: Entity) => Promise<Entity>
  getBy: (username: string) => Promise<Nullable<Entity>>
  update: (user: Entity) => Promise<Entity>
  delete: (user: Entity) => Promise<void>
  getById: (id: string) => Promise<Nullable<Entity>>
}

export default IBaseRepository
