import type IBaseEntityData from './base-data.entity.interface'

interface IBaseEntity<PrimitiveData> extends IBaseEntityData {
  readonly id: string
  readonly createdAt: Date
  readonly updatedAt: Date
  toPrimitive: () => PrimitiveData
  markAsUpdated: () => void
}

export default IBaseEntity
