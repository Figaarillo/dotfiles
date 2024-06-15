class StoreUserUserCase {
  #some: string
  constructor() {
    this.#some = ''
  }

  get some(): string {
    return this.#some
  }
}

export default StoreUserUserCase
