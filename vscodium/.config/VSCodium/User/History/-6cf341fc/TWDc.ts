import { UserFirstName } from "../object-values/user.object-value"

interface IUserPayload {
  firstName: UserFirstName
  lastName: string
  phoneNumber: number
  birthday: string
};

export default IUserPayload
