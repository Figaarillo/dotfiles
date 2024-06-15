import express, { type Application, type Router } from 'express'
import morgan from 'morgan'
import cors from 'cors'
import UserRouter from './router/user.router'
import ConfigServer from './config/config'

class ServerBoostrap extends ConfigServer {
  public app: Application
  private readonly port: number

  constructor() {
    super()

    this.app = express()
    this.port = this.getNumberEnviroment('PORT')

    // middlewares
    this.app.use(express.json())
    this.app.use(express.urlencoded({ extended: true }))
    this.app.use(morgan('dev'))
    this.app.use(cors())

    // routes
    this.app.use('/api', this.routes())

    // server
    this.listen()
  }

  public routes(): Router[] {
    return [new UserRouter().router]
  }

  public listen(): void {
    this.app.listen(this.port, () => {
      // eslint-disable-next-line no-console
      console.log(`Server is listening on http://localhost:${this.port}/`)
    })
  }
}

// eslint-disable-next-line no-new
new ServerBoostrap()

export default ServerBoostrap
