import UserProps from "../properties/user.props"

interface UserPayload  implements UserProps<string | number>{
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string
};

export default UserPayload
