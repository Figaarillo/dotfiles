/* eslint-disable no-console */
import '@shared/config/env'
import httpServer from '@shared/config/http'
import conncectDB from '@shared/config/mongoose'

const PORT = process.env.PORT ?? 3000
const URI = process.env.MONGODB_URL

;(async () => {
  httpServer.listen(PORT, () => {
    console.log(`Server is running! go to http://localhost:${PORT}`)
  })

  if (URI !== undefined) {
    await conncectDB(URI)
  }
})()

const hello = () => {
  const grettings = 'Hello World!'

  return grettings
}

