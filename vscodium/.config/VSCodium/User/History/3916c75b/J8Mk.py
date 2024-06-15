# Value Object: Email
class Email:
    def __init__(self, value: str):
        self.value = value

    @staticmethod
    def create(email: str):
        if re.match(r'\S+@\S+\.\S+', email):
            return Email(email)
        return None

    def get_value(self):
        return self.value

# Value Object: ID
class ID:
    def __init__(self, value: int):
        self.value = value

    @staticmethod
    def create(id: int):
        if id > 0:
            return ID(id)
        return None

    def get_value(self):
        return self.value

# Value Object: Name
class Name:
    def __init__(self, value: str):
        self.value = value

    @staticmethod
    def create(name: str):
        if name.strip():
            return Name(name)
        return None

    def get_value(self):
        return self.value

# Domain Layer
class UserRepository:
    def find_user_by_id(self, id: ID):
        for user in self.users:
            if user.id.get_value() == id.get_value():
                return user
        return None

    def save_user(self, user):
        self.users.append(user)

class User:
    def __init__(self, id: ID, name: Name, email: Email):
        self.id = id
        self.name = name
        self.email = email

# Infrastructure Layer
class InMemoryUserRepository(UserRepository):
    def __init__(self):
        self.users = []

# Application Layer
class UserService:
    def __init__(self, repository):
        self.repository = repository

    def get_user_by_id(self, id: ID):
        return self.repository.find_user_by_id(id)

    def create_user(self, name_str, email_str):
        name = Name.create(name_str)
        if name:
            email = Email.create(email_str)
            if email:
                user = User(ID.create(1), name, email)  # Generate a unique ID in a real application
                self.repository.save_user(user)
                return user
        return None

# Presentation Layer / Main Function
def main():
    repository = InMemoryUserRepository()
    service = UserService(repository)

    user = service.create_user("John Doe", "johndoe@example.com")

    if user:
        retrieved_user = service.get_user_by_id(user.id)
        print(retrieved_user)
    else:
        print("Invalid name, email, or ID. User not created.")

if __name__ == "__main__":
    import re
    main()
