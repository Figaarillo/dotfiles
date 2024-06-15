import { Birthday, FirstName, LastName, PhoneNumber } from "../value-objects/user.value-object"

interface UserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
};

export default UserPayload
