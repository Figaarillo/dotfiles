import { type FirstName, type LastName, type PhoneNumber, type Birthday } from '../value-objects/user.value-object'

interface IUserEntity {
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
};

export default IUserEntity
