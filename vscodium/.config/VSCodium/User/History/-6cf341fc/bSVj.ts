import { UserFirstName, UserLastName } from "../object-values/user.object-value"

interface IUserPayload {
  firstName: UserFirstName
  lastName: UserLastName
  phoneNumber: number
  birthday: string
};

export default IUserPayload
