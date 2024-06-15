import type IBaseEntityData from './base-data.entity.interface'

interface IBaseEntity<PrimitiveData> extends IBaseEntityData {
  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
