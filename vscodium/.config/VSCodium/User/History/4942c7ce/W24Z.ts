/* eslint-disable no-console */
import express, { type Application, type Router } from 'express'
import morgan from 'morgan'
import cors from 'cors'
import UserRouter from './user/user.router'
import ConfigServer from './config/config'
import 'reflect-metadata'
import CategoryRouter from './category/category.router'
import CustomerRouter from './customer/customer.router'
import ProductRouter from './product/product.router'
import PurchaseRouter from './purchase/purchase.router'
import PurchaseProductRouter from './purchase/purchsae-product.router'
import LoginStrattegy from './auth/strategies/login.strategy'
import JWTStrategy from './auth/strategies/jwt.strategy'
import AuthRouter from './auth/auth.router'

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

    // passport
    this.passportUse()

    // routes
    this.app.use('/api', this.routes())

    // server
    this.listen()
    this.dbConnection()
  }

  public routes(): Router[] {
    return [
      new CategoryRouter().router,
      new CustomerRouter().router,
      new ProductRouter().router,
      new PurchaseRouter().router,
      new PurchaseProductRouter().router,
      new UserRouter().router,
      new AuthRouter().router,
    ]
  }

  // eslint-disable-next-line @typescript-eslint/explicit-function-return-type
  passportUse() {
    // eslint-disable-next-line @typescript-eslint/no-confusing-void-expression
    return [new LoginStrattegy().use(), new JWTStrategy().use()]
  }

  async dbConnection(): Promise<void> {
    await this.initDBConnection
      .then(() => {
        console.log('🚀  Database Connected')
      })
      .catch((error: string) => {
        console.log(`🚀 Database Connection Error: ${error}`)
      })
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
