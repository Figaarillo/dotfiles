// Value Object: Email
class Email {
    private constructor(private value: string) { }

    static create(email: string): Email | undefined {
        if (/\S+@\S+\.\S+/.test(email)) {
            return new Email(email);
        }
        return undefined; // Return undefined for an invalid email
    }

    getValue(): string {
        return this.value;
    }
}
// Value Object: ID
class ID {
    private constructor(private value: number) { }

    static create(id: number): ID | undefined {
        if (id > 0) {
            return new ID(id);
        }
        return undefined; // Return undefined for an invalid ID
    }

    getValue(): number {
        return this.value;
    }
}

// Value Object: Name
class Name {
    private constructor(private value: string) { }

    static create(name: string): Name | undefined {
        if (name.trim() !== "") {
            return new Name(name);
        }
        return undefined; // Return undefined for an empty or whitespace-only name
    }

    getValue(): string {
        return this.value;
    }
}

// Domain Layer
interface UserRepository {
    findUserById(id: ID): User | undefined;
    saveUser(user: User): void;
}

class User {
    id: ID;
    name: Name;
    email: Email;
    
    constructor(id: ID, name: Name, email: Email) {
        this.id = id
        this.name = name
        this.email = email
    }
}

// Infrastructure Layer
class InMemoryUserRepository implements UserRepository {
    private users: User[] = [];

    findUserById(id: ID): User | undefined {
        return this.users.find((user) => user.id.getValue() === id.getValue());
    }

    saveUser(user: User): void {
        this.users.push(user);
    }
}

// Application Layer
class UserService {
    constructor(private repository: UserRepository) { }

    getUserById(id: ID): User | undefined {
        return this.repository.findUserById(id);
    }

    createUser(nameStr: string, emailStr: string): User | undefined {
        const name = Name.create(nameStr);
        if (name) {
            const email = Email.create(emailStr);
            if (email) {
                const user = new User(ID.create(1)!, name, email); // Generate a unique ID in a real application
                this.repository.saveUser(user);
                return user;
            }
        }
        return undefined; // Return undefined for invalid name or email
    }
}

// Presentation Layer / Main Function
function main() {
    const repository: UserRepository = new InMemoryUserRepository();
    const service = new UserService(repository);

    const user = service.createUser("John Doe", "johndoe@example.com");

    if (user) {
        const retrievedUser = service.getUserById(user.id);
        console.log(retrievedUser);
    } else {
        console.log("Invalid name, email, or ID. User not created.");
    }
}

main();
