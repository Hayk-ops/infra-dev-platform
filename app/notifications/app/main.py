from fastapi import FastAPI
from pydantic import BaseModel
import os, time

app = FastAPI(title="notifications", version=os.getenv("SERVICE_VERSION", "0.0.0"))

class NotifyReq(BaseModel):
    user_id: str
    channel: str  # "email" | "sms" | "push"
    message: str

NOTICES: list[dict] = []

@app.get("/healthz")
def healthz(): return {"status": "ok"}

@app.get("/readyz")
def readyz(): return {"ready": True}

@app.get("/version")
def version(): return {"name": "notifications", "version": os.getenv("SERVICE_VERSION", "0.0.0")}

@app.post("/notify")
def notify(req: NotifyReq):
    evt = {"ts": int(time.time()), **req.model_dump()}
    NOTICES.append(evt)
    return {"status": "queued", "event": evt}

@app.get("/notifications")
def list_notifications(limit: int = 20):
    return {"items": NOTICES[-limit:]}
