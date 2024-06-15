import { FirstName, LastName, PhoneNumber } from "../value-objects/user.value-object"

interface UserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: string
};

export default UserPayload
