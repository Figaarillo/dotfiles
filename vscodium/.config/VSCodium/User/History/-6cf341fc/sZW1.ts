
interface UserPayload extends UserProps<string | number> {
  firstName: string
  lastName: string
  phoneNumber: number
  birthday: string
};

export default UserPayload
