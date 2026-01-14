from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.services.auth_service import verify_user, add_user


router = APIRouter()


class LoginRequest(BaseModel):
    email: str
    password: str


class SignupRequest(BaseModel):
    name: str
    email: str
    password: str


@router.post("/login")
def login(data: LoginRequest):
    print("LOGIN REQUEST RECEIVED:", data.email)

    if not verify_user(data.email, data.password):
        print("LOGIN FAILED")
        raise HTTPException(status_code=401, detail="Invalid credentials")

    print("LOGIN SUCCESS")
    return {"message": "Login successful"}


@router.post("/signup", status_code=201)
def signup(data: SignupRequest):
    print("SIGNUP REQUEST RECEIVED:", data.email, data.name)

    added = add_user(data.name, data.email, data.password)
    if not added:
        print("SIGNUP FAILED - USER EXISTS")
        raise HTTPException(status_code=400, detail="User already exists")

    print("SIGNUP SUCCESS")
    return {"message": "User created"}

