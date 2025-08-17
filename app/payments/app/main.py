from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import os, uuid

app = FastAPI(title="payments", version=os.getenv("SERVICE_VERSION", "0.0.0"))

class ChargeReq(BaseModel):
    user_id: str
    order_id: str
    amount: float = Field(gt=0)

PAYMENTS: dict[str, dict] = {}

@app.get("/healthz")
def healthz(): return {"status": "ok"}

@app.get("/readyz")
def readyz(): return {"ready": True}

@app.get("/version")
def version(): return {"name": "payments", "version": os.getenv("SERVICE_VERSION", "0.0.0")}

@app.post("/charge")
def charge(req: ChargeReq):
    pid = str(uuid.uuid4())
    PAYMENTS[pid] = {"id": pid, "status": "authorized", **req.model_dump()}
    return PAYMENTS[pid]

@app.get("/payments/{payment_id}")
def get_payment(payment_id: str):
    if payment_id not in PAYMENTS:
        raise HTTPException(status_code=404, detail="not found")
    return PAYMENTS[payment_id]
