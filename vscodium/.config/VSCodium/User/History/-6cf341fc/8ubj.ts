import { type UserBirthday, type UserFirstName, type UserLastName, type UserPhoneNumber } from '../object-values/user.object-value'

interface IUserPayload {
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string
};

export default IUserPayload
