
interface IBaseEntity<PrimitiveData> extends IBaseEntityData {
  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
