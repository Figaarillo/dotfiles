/* eslint-disable n/no-path-concat */
import * as dotenv from 'dotenv'
import { type DataSourceOptions } from 'typeorm'
import { SnakeNamingStrategy } from 'typeorm-naming-strategies'

abstract class ConfigServer {
  constructor() {
    const nodeNameEnv = this.createPathEnv(this.getNodeEnv())
    dotenv.config({
      path: nodeNameEnv,
    })
  }

  public getEnviroment(key: string): string | undefined {
    return process.env[key.toUpperCase()]
  }

  public getNumberEnviroment(key: string): number {
    return Number(this.getEnviroment(key))
  }

  public getNodeEnv(): string {
    return this.getEnviroment('NODE_ENV')?.trim() ?? ''
  }

  public createPathEnv(path: string): string {
    const ENV: string = '.env'

    if (path.length > 0) {
      return `${ENV}.${path}`
    }

    return ENV
  }

  public get typeORMConfig(): DataSourceOptions {
    return {
      type: 'mysql',
      host: this.getEnviroment('DB_HOST'),
      port: this.getNumberEnviroment('DB_PORT'),
      username: this.getEnviroment('DB_USER'),
      password: this.getEnviroment('DB_PASSWORD'),
      database: this.getEnviroment('DB_DATABASE'),
      entities: [__dirname + '/../**/*.entity{.ts,.js}'],
      migrations: [__dirname + '/../../migrations/*{.ts, .js}'],
      synchronize: true,
      logging: false,
      namingStrategy: new SnakeNamingStrategy(),
    }
  }
}

export default ConfigServer
