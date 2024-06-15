
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

import React, { useState } from 'react';

// Domain Layer
class UserRepository {
  constructor() {
    this.users = [];
  }

  findUserById(id) {
    return this.users.find(user => user.id.getValue() === id.getValue());
  }

  saveUser(user) {
    this.users.push(user);
  }
}

class User {
  constructor(id, name, email) {
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
  constructor(repository) {
    this.repository = repository;
  }

  getUserById(id) {
    return this.repository.findUserById(id);
  }

  createUser(nameStr, emailStr) {
    const name = Name.create(nameStr);
    if (name) {
      const email = Email.create(emailStr);
      if (email) {
        const user = new User(ID.create(1), name, email); // Generate a unique ID in a real application
        this.repository.saveUser(user);
        return user;
      }
    }
    return null;
  }
}

// Presentation Layer
function App() {
  const repository = new InMemoryUserRepository();
  const [service] = useState(new UserService(repository));

  const user = service.createUser('John Doe', 'johndoe@example.com');

  if (user) {
    const retrievedUser = service.getUserById(user.id);
    return (
      <div>
        <pre>{JSON.stringify(user, null, 2)}</pre>
        <pre>{JSON.stringify(retrievedUser, null, 2)}</pre>
      </div>
    );
  } else {
    return <div>Invalid name, email, or ID. User not created.</div>;
  }
}

export default App;
