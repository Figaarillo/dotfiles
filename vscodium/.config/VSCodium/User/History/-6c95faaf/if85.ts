interface IBaseEntity<PrimitiveData> {
 	readonly id: string
  readonly createdAt: Date
  readonly updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
