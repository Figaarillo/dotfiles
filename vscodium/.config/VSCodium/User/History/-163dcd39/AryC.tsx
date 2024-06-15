// Value Object: Email
class Email {
  value: string;

  constructor(value: string) {
    this.value = value;
  }

  static create(email: string): Email | null {
    if (/\S+@\S+\.\S+/.test(email)) {
      return new Email(email);
    }
    return null;
  }

  getValue() {
    return this.value;
  }
}

// Value Object: ID
class ID {
  value: string;
  
  constructor(value: string) {
    this.value = value;
  }

  static create(id: number) {
    if (id > 0) {
      return new ID(id);
    }
    return null;
  }

  getValue() {
    return this.value;
  }
}

// Value Object: Name
class Name {
  value: string;

  constructor(value: string) {
    this.value = value;
  }

  static create(name) {
    if (name.trim() !== '') {
      return new Name(name);
    }
    return null;
  }

  getValue() {
    return this.value;
  }
}

// Domain Layer
class UserRepository {
  users: User[];

  constructor() {
    this.users = [];
  }

  findUserById(id: ID): User | undefined {
    return this.users.find(user => user.id.getValue() === id.getValue());
  }

  saveUser(user: User): void {
    this.users.push(user);
  }
}

class User {
  id: ID
  name: Name
  email: Email

  constructor(id: ID, name: Name, email: Email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }
}

// Infrastructure Layer
class InMemoryUserRepository extends UserRepository {
  constructor() {
    super();
  }
}

// Application Layer
class UserService {
  private repository: UserRepository;

  constructor(repository: UserRepository) {
    this.repository = repository;
  }

  getUserById(id: ID) {
    return this.repository.findUserById(id);
  }

  createUser(nameStr: string, emailStr: string): User | undefined {
    const name = Name.create(nameStr);
    if (!name) {
      return undefined;
    }

    const email = Email.create(emailStr);
    if (!email) {
      return undefined;
    }

    const user = new User(ID.create(1)!, name, email);
    this.repository.saveUser(user);
    return user;
  }
}

import React from 'react';

// Presentation Layer
function App() {
  const repository: UserRepository = new InMemoryUserRepository();
  const service = new UserService(repository);

  const user = service.createUser('John Doe', 'johndoe@example.com');

  if (user) {
    const retrievedUser = service.getUserById(user.id);
    return (
      <div>
        <div>{user.name}</div>
        <div>{user.email}</div>
      </div>
    );
  } else {
    return <div>Invalid name, email, or ID. User not created.</div>;
  }
}

export default App;
