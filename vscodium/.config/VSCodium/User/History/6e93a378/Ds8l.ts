import { type Request, type Response } from 'express'

class UserController {
  // eslint-disable-next-line @typescript-eslint/explicit-function-return-type
  getUsers(req: Request, res: Response) {
    res.status(201).json({
      message: 'Hello, user!'
    })
  }
}

export default UserController
