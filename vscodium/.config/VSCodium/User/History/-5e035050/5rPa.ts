interface IBaseRepository<Entity>{
	getAll: () => Promise<User[]>
	save: (user: User) => Promise<User>
	getBy: (username: string) => Promise<Nullable<User>>
	update: (user: User) => Promise<User>
	delete: (user: User) => Promise<void>
	getById: (id: string) => Promise<Nullable<User>>
}