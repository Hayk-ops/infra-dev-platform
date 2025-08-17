from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import os

app = FastAPI(title="user-profile", version=os.getenv("SERVICE_VERSION", "0.0.0"))

class Profile(BaseModel):
    id: str
    email: EmailStr
    name: str | None = None

DB: dict[str, Profile] = {}

@app.get("/healthz")
def healthz(): return {"status": "ok"}

@app.get("/readyz")
def readyz(): return {"ready": True}

@app.get("/version")
def version(): return {"name": "user-profile", "version": os.getenv("SERVICE_VERSION", "0.0.0")}

@app.get("/users/{uid}", response_model=Profile)
def get_user(uid: str):
    if uid not in DB:
        raise HTTPException(status_code=404, detail="not found")
    return DB[uid]

@app.put("/users/{uid}", response_model=Profile)
def upsert_user(uid: str, body: Profile):
    DB[uid] = body
    return body
