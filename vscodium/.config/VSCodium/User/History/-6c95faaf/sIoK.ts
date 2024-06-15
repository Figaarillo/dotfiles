interface IBaseEntity<PrimitiveData> {
  readonly id: string
  readonly createdAt: Date
  readonly updatedAt: Date
}

export default IBaseEntity
