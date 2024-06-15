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

    pub fn create_user(&mut self, name: String) -> User {
        let user = User {
            id: 1, // Generate unique ID in a real application
            name,
        };
        self.repository.save_user(user.clone());
        user
    }
}

// Presentation Layer / Main Function  
fn main() {  
    let repository = Box::new(InMemoryUserRepository { users: vec![] });  
    let mut service = UserService::new(repository);

    let user = service.create_user("John Doe".to_string());

    let retrieved_user = service.get_user_by_id(user.id);
    println!("{:?}", retrieved_user);
}
