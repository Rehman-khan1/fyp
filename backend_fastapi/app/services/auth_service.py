# TEMPORARY AUTH SERVICE (NO BCRYPT)

fake_users = {
    "zeeshan@gmail.com": "12345678"
}

def verify_user(email: str, password: str) -> bool:
    if email not in fake_users:
        return False
    return fake_users[email] == password
