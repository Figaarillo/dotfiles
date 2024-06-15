interface IBaseEntity<Entity, PrimitiveData> {
	readonly id: string
	readonly createdAt: Date
	readonly updatedAt: Date

	toPrimitive: () => PrimitiveData
	markAsUpdated: () => void
	equals: (other: IBaseEntity<Entity, PrimitiveData>) => boolean
}
