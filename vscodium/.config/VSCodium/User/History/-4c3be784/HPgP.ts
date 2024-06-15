import type UserPayload from './user.payload'

interface UpdateUserPayload extends UserPayload {
  id: string
}

export default UpdateUserPayload
