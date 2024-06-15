class StoreUserUserCase {
  #some: string
  constructor() {
    this.#some = ''
  }

  get some() {
    return this.#some
  }
}

export default StoreUserUserCase
