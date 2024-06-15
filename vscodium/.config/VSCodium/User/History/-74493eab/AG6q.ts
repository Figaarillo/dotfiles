import { type UserBirthday, type UserFirstName, type UserLastName, type UserPhoneNumber } from '../object-values/user.object-value'

interface IUser {
  firstName: UserFirstName
  lastName: UserLastName
  phoneNumber: UserPhoneNumber
  birthday: UserBirthday
};

export default IUser
