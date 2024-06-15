import { type Birthday, type FirstName, type LastName, type PhoneNumber } from '../value-objects/user.value-object'

interface UserPayload {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
};

export default UserPayload
