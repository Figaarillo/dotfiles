/* eslint-disable @typescript-eslint/method-signature-style */
import { type Nullable } from '@shared/domain/types/nullable.type'

interface IBaseRepository<Entity> {
  getAll(): Promise<Entity[]>
  save(entity: Entity): Promise<Entity>
  getBy(property: string): Promise<Nullable<Entity>>
  update(entity: Entity): Promise<Entity>
  delete(entity: Entity): Promise<void>
  getById(id: string): Promise<Nullable<Entity>>
}

export default IBaseRepository
