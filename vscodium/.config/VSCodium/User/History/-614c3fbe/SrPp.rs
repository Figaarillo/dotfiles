// Domain Layer
pub trait UserRepository {
    fn find_user_by_id(&self, id: u32) -> Option<User>;
    fn save_user(&mut self, user: User);
}

pub struct User {
    pub id: u32,
    pub name: String,
}

// Infrastructure Layer
pub struct InMemoryUserRepository {
    users: Vec<User>,
}

impl UserRepository for InMemoryUserRepository {
    fn find_user_by_id(&self, id: u32) -> Option<User> {
        self.users.iter().find(|user| user.id == id).cloned()
    }

    fn save_user(&mut self, user: User) {
        self.users.push(user);
    }
}

// Application Layer
pub struct UserService {
    repository: Box<dyn UserRepository>,
}

impl UserService {
    pub fn new(repository: Box<dyn UserRepository>) -> Self {
        Self { repository }
    }

    pub fn get_user_by_id(&self, id: u32) -> Option<User> {
        self.repository.find_user_by_id(id)
    }

    pub fn create_user(&mut self, name: String) {
        let user = User {
            id: 1, // Generate unique ID in a real application
            name,
        };
        self.repository.save_user(user);
    }
}

// Presentation Layer / Main Function
fn main() {
    let repository = Box::new(InMemoryUserRepository { users: vec![] });
    let mut service = UserService::new(repository);

    service.create_user("John Doe".to_string());

    let user = service.get_user_by_id(1);
    println!("{:?}", user);
}

// In this example, we have three layers: the Domain Layer, Infrastructure Layer, and Application Layer.
//
// - The Domain Layer defines the core business entities (`User`) and the repository interface (`UserRepository`).
// - The Infrastructure Layer provides an implementation of the repository interface using an in-memory data structure (`InMemoryUserRepository`).
// - The Application Layer contains the service (`UserService`) that interacts with the repository and performs business logic.
//
// The main function in the Presentation Layer demonstrates how to use the Hexagonal Architecture pattern by creating an instance of the service, calling its methods, and interacting with the repository.
//
// Please note that this is a simplified example, and in a real-world scenario, you would typically have more complex interactions and dependencies between the layers.
