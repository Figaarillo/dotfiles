interface IBaseEntity<PrimitiveData> {
 	protect readonly _id: string
  protect readonly _createdAt: Date
  protect readonly _updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
