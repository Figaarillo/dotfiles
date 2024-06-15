interface IBaseEntity<PrimitiveData> {
 	protect readony _id: string
  protect readony _createdAt: Date
  protect readony _updatedAt: Date

  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
