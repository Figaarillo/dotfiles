import { type FirstName, type LastName, type Birthday } from '../value-objects/user.value-object'

interface IUser {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
};

export default IUser
