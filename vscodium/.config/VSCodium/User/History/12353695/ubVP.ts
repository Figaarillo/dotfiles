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
  private atribute: any

  constructor() {
      this.atribute = 1
    }
    

    get atribute() {
      return this.atribute
    }
  }
}
export default UserRouter
