import { Router } from 'express'

class BaseRouter<T> {
  public router: Router
  public controller: T

  constructor(Controller: new() => T) {
    this.router = Router()
    this.controller = new Controller()
    this.routes()
  }

  routes(): void {}
}

export default BaseRouter
