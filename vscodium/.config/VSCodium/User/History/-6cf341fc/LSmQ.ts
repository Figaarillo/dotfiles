import { FirstName } from "../value-objects/user.value-object"

interface UserPayload {
  firstName: FirstName
  lastName: string
  phoneNumber: number
  birthday: string
};

export default UserPayload
