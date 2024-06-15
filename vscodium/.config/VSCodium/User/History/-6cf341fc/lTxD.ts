import type UserProps from '../properties/user.props'

interface UserPayload extends UserProps<string | number> {
  firstName: string
  phoneNumber: number
  birthday: string
};

export default UserPayload
