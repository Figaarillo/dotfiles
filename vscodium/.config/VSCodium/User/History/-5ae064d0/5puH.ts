/* eslint-disable no-console */
import * as dotenv from 'dotenv'

abstract class ConfigServer {
  constructor() {
    const nodeNameEnv = this.createPathEnv(this.getNodeEnv())
    // eslint-disable-next-line no-console
    console.log(nodeNameEnv)
    dotenv.config({
      path: nodeNameEnv
    })
  }

  public getEnviroment(key: string): string | undefined {
    return process.env[key.toUpperCase()]
  }

  public getNumberEnviroment(key: string): number {
    return Number(this.getEnviroment(key))
  }

  public getNodeEnv(): string {
    const env = this.getEnviroment('NODE_ENV')?.trim() ?? ''
    console.log({ env })
    return env
  }

  public createPathEnv(path: string): string {
    const enviroments: string[] = ['env']

    if (path.length > 0) {
      const stringToArray = path.split('.')
      enviroments.push(...stringToArray)
    }

    return `.${enviroments.join('.')}`
  }
}

export default ConfigServer
