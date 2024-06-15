interface IBaseEntity<PrimitiveData> {
  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
