interface IBaseRepository<Entity>{
	getAll: () => Promise<
	save: (user: User) => Promise<
	getBy: (username: string) => Promise<Nullable<
	update: (user: User) => Promise<
	delete: (user: User) => Promise<void>
	getById: (id: string) => Promise<Nullable<
}