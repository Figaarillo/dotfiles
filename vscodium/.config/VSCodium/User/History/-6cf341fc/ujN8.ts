import UserProps from "../properties/user.props"

interface UserPayload  implements UserProps{
  firstName: FirstName
  lastName: LastName
  phoneNumber: PhoneNumber
  birthday: Birthday
};

export default UserPayload
