import { FirstName, LastName } from "../value-objects/user.value-object"

interface UserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: number
  birthday: string
};

export default UserPayload
