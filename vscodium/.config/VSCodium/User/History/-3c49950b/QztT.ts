import ImmutableEntity from './immutable.entity'
import { v4 as uuidv4 } from 'uuid'

abstract class BaseEntity<Entity, PrimitiveData, Payload> extends ImmutableEntity<PrimitiveData> {
  // TODO: add value object
  protected readonly _id: string
  protected readonly _createdAt: Date
  protected _updatedAt: Date

  constructor(data: PrimitiveData) {
    super(data)
    this._id = uuidv4()
    this._createdAt = new Date()
    this._updatedAt = new Date()
  }

  get id(): string {
    return this._id
  }

  get createdAt(): Date {
    return this._createdAt
  }

  get updatedAt(): Date {
    return this._updatedAt
  }

  abstract toPrimitive(): Payload

  markAsUpdated(): void {
    this._updatedAt = new Date()
  }

  equals(other: BaseEntity<Entity, PrimitiveData, Payload>): boolean {
    return this.id === other.id
  }
}

export default BaseEntity
