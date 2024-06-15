// Value Object: Email
struct Email {
    value: String,
}

impl Email {
    fn create(email: &str) -> Option<Self> {
        if regex::Regex::new(r"\S+@\S+\.\S+").unwrap().is_match(email) {
            Some(Email {
                value: email.to_string(),
            })
        } else {
            None
        }
    }
}

impl std::fmt::Debug for Email {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Email {{ value: '{}' }}", self.value)
    }
}

// Value Object: ID
struct ID {
    value: u32,
}

impl ID {
    fn create(id: u32) -> Option<Self> {
        if id > 0 {
            Some(ID { value: id })
        } else {
            None
        }
    }
}

impl std::fmt::Debug for ID {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "ID {{ value: {} }}", self.value)
    }
}

// Value Object: Name
struct Name {
    value: String,
}

impl Name {
    fn create(name: &str) -> Option<Self> {
        if !name.trim().is_empty() {
            Some(Name {
                value: name.to_string(),
            })
        } else {
            None
        }
    }
}

impl std::fmt::Debug for Name {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Name {{ value: '{}' }}", self.value)
    }
}

// Domain Layer
struct User {
    id: ID,
    name: Name,
    email: Email,
}

struct UserRepository {
    users: Vec<User>,
}

impl UserRepository {
    fn find_user_by_id(&self, id: &ID) -> Option<User> {
        self.users.iter().find(|user| &user.id == id).cloned()
    }

    fn save_user(&mut self, user: User) {
        self.users.push(user);
    }
}

// Application Layer
struct UserService {
    repository: UserRepository,
}

impl UserService {
    fn get_user_by_id(&self, id: &ID) -> Option<User> {
        self.repository.find_user_by_id(id)
    }

    fn create_user(&mut self, name: &str, email: &str) -> Option<User> {
        let name = Name::create(name)?;
        let email = Email::create(email)?;
        let user = User {
            id: ID::create(1)?, // Generate a unique ID in a real application
            name,
            email,
        };
        self.repository.save_user(user.clone());
        Some(user)
    }
}

fn main() {
    let repository = UserRepository { users: vec![] };
    let mut service = UserService { repository };

    if let Some(user) = service.create_user("John Doe", "johndoe@example.com") {
        let retrieved_user = service.get_user_by_id(&user.id);
        println!("{:?}", user);
        println!("{:?}", retrieved_user);
    } else {
        println!("Invalid name, email, or ID. User not created.");
    }
}
