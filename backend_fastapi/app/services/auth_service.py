# TEMPORARY AUTH SERVICE (NO BCRYPT)

# Store users as email -> {"password": str, "name": str}
fake_users = {
    "zeeshan@gmail.com": {"password": "12345678", "name": "Zeeshan"}
}

def verify_user(email: str, password: str) -> bool:
    user = fake_users.get(email)
    if not user:
        return False
    return user.get("password") == password

def add_user(name: str, email: str, password: str) -> bool:
    """Add a new user. Returns False if user already exists, True if added."""
    if email in fake_users:
        return False
    fake_users[email] = {"password": password, "name": name}
    return True
