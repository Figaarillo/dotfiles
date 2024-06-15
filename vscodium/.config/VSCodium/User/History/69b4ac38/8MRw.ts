import express from 'express'
import morgan from 'morgan'
import cors from 'cors'

class ServerBoostrap {
  public app: express.Application
  private readonly port: number

  constructor() {
    this.app = express()
    this.app.use(express.json)
    this.app.use(express.urlencoded({ extended: true }))
    this.app.use(morgan('dev'))
    this.app.use(cors())
    this.port = 8000
    this.listen()
  }

  public listen() {
    this.app.listen(this.port, () => {
      console.log(`Server is runnig! Go to http://localhost:${this.port}`) 
    })
  }
}

new ServerBoostrap()

export default ServerBoostrap
