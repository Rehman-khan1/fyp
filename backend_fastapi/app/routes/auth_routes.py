from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.services.auth_service import verify_user


router = APIRouter()

class LoginRequest(BaseModel):
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

