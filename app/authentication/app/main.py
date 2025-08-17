from fastapi import FastAPI, Header, HTTPException
from pydantic import BaseModel
import os

app = FastAPI(title="authentication", version=os.getenv("SERVICE_VERSION", "v0"))

class LoginReq(BaseModel):
    username: str
    password: str

@app.get("/healthz")
def healthz():
    return {"status": "ok"}

@app.get("/readyz")
def readyz():
    return {"ready": True}

@app.get("/version")
def version():
    return {"name": "authentication", "version": os.getenv("SERVICE_VERSION", "v0")}

@app.post("/login")
def login(body: LoginReq):
    if not body.username or not body.password:
        raise HTTPException(status_code=400, detail="missing credentials")
    token = f"fake-jwt-for-{body.username}"
    return {"access_token": token, "token_type": "bearer"}

@app.get("/me")
def me(authorization: str | None = Header(default=None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="missing Authorizationss")
    return {"user": authorization.replace("Bearer ", ""), "roles": ["user"]}
