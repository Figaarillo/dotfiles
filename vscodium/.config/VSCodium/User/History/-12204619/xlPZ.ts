import type Nullable from '@shared/domain/types/nullable.type'
import type IBaseRepository from '../interfaces/base.repository.interface'
import type IBaseEntity from '@shared/domain/interfaces/base.entity.interface'

class BaseInMemoryRepository<Entity extends IBaseEntity> implements IBaseRepository<Entity> {
  #entityData: Entity[] = []

  async getAll(): Promise<Entity[]> {
    const entity = this.#entityData

    return entity
  }

  async save(entity: Entity): Promise<Entity> {
    this.#entityData.push(entity)

    return entity
  }

  async getBy(property: string): Promise<Nullable<Entity>> {
    const entityFoundByProperty: any = this.#entityData.find((entity: any) => entity[property] === property)

    if (entityFoundByProperty === undefined) return null

    return entityFoundByProperty
  }

  async update(entity: Entity): Promise<Entity> {
    this.#entityData = this.#entityData.map(entityStored => entityStored.id === entity.id ? entity : entityStored)

    return entity
  }

  async delete(entity: Entity): Promise<void> {
    const entities = this.#entityData.filter(entityStored => {
      return entityStored.id !== entity.id
    })

    this.#entityData = entities
  }

  async getById(id: string): Promise<Nullable<Entity>> {
    const entityFound = this.#entityData.find(entity => entity.id === id)

    if (entityFound === undefined) return null

    return entityFound
  }
}

export default BaseInMemoryRepository
