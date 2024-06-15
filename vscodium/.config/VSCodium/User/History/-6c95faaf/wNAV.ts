interface IBaseEntity<PrimitiveData> {
  readonly _id: string
  readonly _createdAt: Date
  readonly _updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
