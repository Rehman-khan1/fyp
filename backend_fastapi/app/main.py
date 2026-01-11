from fastapi import FastAPI
from app.routes.auth_routes import router as auth_router

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Smart Food Analyzer Backend Running"}

app.include_router(auth_router, prefix="/auth")
