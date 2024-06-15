abstract class ImmutableEntity<T> {
  protected readonly data: T

  constructor(data: T) {
    this.data = Object.freeze(data)
  }

  update(updatedData: Partial<T>): this {
    const newData = { ...this.data, ...updatedData }
    return new (this.constructor as any)(newData)
  }
}

export default ImmutableEntity
