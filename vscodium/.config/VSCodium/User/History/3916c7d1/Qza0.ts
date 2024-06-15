// Domain Layer  
interface UserRepository {  
    findUserById(id: number): User | undefined;  
    saveUser(user: User): void;  
}

class User {  
    constructor(public id: number, public name: string) {}  
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
    constructor(private repository: UserRepository) {}

    getUserById(id: number): User | undefined {
        return this.repository.findUserById(id);
    }

    createUser(name: string): User {
        const user = new User(1, name); // Generate a unique ID in a real application
        this.repository.saveUser(user);
        return user;
    }
}

// Presentation Layer / Main Function
function main() {
    const repository: UserRepository = new InMemoryUserRepository();
    const service = new UserService(repository);

    const user = service.createUser("John Doe");

    const retrievedUser = service.getUserById(user.id);
    console.log(retrievedUser);
}

main();
