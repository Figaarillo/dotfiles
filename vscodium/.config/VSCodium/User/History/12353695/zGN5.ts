import { type Request, type Response } from 'express'
import UserController from '../controllers/user.controller'
import BaseRouter from './router'

class UserRouter extends BaseRouter<UserController> {
  constructor() {
    super(UserController)
  }

  routes(): void {
    this.router.get('/user', (req: Request, res: Response) => {
      this.controller.getUsers(req, res)
    })
  }
}
export class AnotherClass {
  private _atribute: any

  constructor() {
      this._atribute = 1
    }
    

    get atribute() {
      return this._atribute
    }
  }
}
export default UserRouter
