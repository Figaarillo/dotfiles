interface IBaseRepository<Entity> {
  getAll: () => Promise<Entity[]>
  save: (user: User) => Promise<Entity>
  getBy: (username: string) => Promise<Nullable<Entity>>
  update: (user: Entity) => Promise<Entity>
  delete: (user: Entity) => Promise<void>
  getById: (id: string) => Promise<Nullable<Entity>>
}

export default IBaseRepository
