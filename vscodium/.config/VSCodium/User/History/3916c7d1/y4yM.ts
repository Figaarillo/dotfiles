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

// Domain Layer
interface UserRepository {
    findUserById(id: number): User | undefined;
    saveUser(user: User): void;
}

class User {
    constructor(public id: number, public name: string, public email: Email) { }
}

// Infrastructure Layer
class InMemoryUserRepository implements UserRepository {
    private users: User[] = [];

    findUserById(id: number): User | undefined {
        return this.users.find((user) => user.id === id);
    }

    saveUser(user: User): void {
        this.users.push(user);
    }
}

// Application Layer
class UserService {
    constructor(private repository: UserRepository) { }

    getUserById(id: number): User | undefined {
        return this.repository.findUserById(id);
    }

    createUser(name: string, emailStr: string): User | undefined {
        const email = Email.create(emailStr);
        if (email) {
            const user = new User(1, name, email); // Generate a unique ID in a real application
            this.repository.saveUser(user);
            return user;
        }
        return undefined; // Return undefined for an invalid email
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
        console.log("Invalid email. User not created.");
    }
}

main();
