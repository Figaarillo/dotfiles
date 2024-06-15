interface IBaseEntity<PrimitiveData> {
 	protected readonly _id: string
  protected readonly _createdAt: Date
  protected readonly _updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
