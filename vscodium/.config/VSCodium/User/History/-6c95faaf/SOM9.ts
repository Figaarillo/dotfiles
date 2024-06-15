interface IBaseEntity<Entity, PrimitiveData> {
  readonly _id: string
  readonly _createdAt: Date
  readonly _updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
  equals: (other: IBaseEntity<Entity, PrimitiveData>) => boolean
}
