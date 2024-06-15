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
consdcklasd;jfkl;dsajfkl;jsadkl;jfkl;jsadkl;jf;lksajd;klfjs;akldfkl;jaskdljflk;asjdf;lksaf;ljas;kdjfk;lsajdkf;ldsa;lfj;FileSystemWritableFileStream;sajf;lasjfkl;as
export default UserRouter
