import { UserId, UserName, UserUsername, UserAge } from "./value-objects";

export interface IUser {
	id: UserId;
	name: UserName;
	username: UserUsername;
	age?: UserAge;
}