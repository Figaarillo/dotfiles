// Domain Layer
pub trait UserRepository {
    fn find_user_by_id(&self, id: u32) -> Option<User>;
    fn save_user(&mut self, user: User);
}

pub struct User {
    pub id: UserId,
    pub name: UserName,
}

// Value Objects
#[derive(Clone)]
pub struct UserId(u32);

#[derive(Clone)]
pub struct UserName(String);

// Infrastructure Layer
pub struct InMemoryUserRepository {
    users: Vec<User>,
}

impl UserRepository for InMemoryUserRepository {
    fn find_user_by_id(&self, id: UserId) -> Option<User> {
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

    pub fn get_user_by_id(&self, id: UserId) -> Option<User> {
        self.repository.find_user_by_id(id)
    }

    pub fn create_user(&mut self, name: UserName) {
        let user = User {
            id: UserId(1), // Generate unique ID in a real application
            name,
        };
        self.repository.save_user(user);
    }
}

// Presentation Layer / Main Function
fn main() {
    let repository = Box::new(InMemoryUserRepository { users: vec![] });
    let mut service = UserService::new(repository);

    service.create_user(UserName("John Doe".to_string()));

    let user = service.get_user_by_id(UserId(1));
    println!("{:?}", user);
}
