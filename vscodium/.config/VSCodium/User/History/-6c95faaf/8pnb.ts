interface IBaseEntity<PrimitiveData> extends IBase {
  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
