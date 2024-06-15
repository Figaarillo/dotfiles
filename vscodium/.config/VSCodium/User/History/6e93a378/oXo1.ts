import { type Request, type Response } from 'express'

class UserController {
  getUsers(req: Request, res: Response) {
    res.status(201).json({
      message: 'Hello, user!'
    })
  }
}

export default UserController
