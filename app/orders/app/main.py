from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import os, uuid

app = FastAPI(title="orders", version=os.getenv("SERVICE_VERSION", "0.0.0"))

class OrderIn(BaseModel):
    user_id: str
    item: str
    qty: int = Field(gt=0)

ORDERS: dict[str, dict] = {}

@app.get("/healthz") 
def healthz(): return {"status": "ok"}

@app.get("/readyz")
def readyz(): return {"ready": True}

@app.get("/version")
def version(): return {"name": "orders", "version": os.getenv("SERVICE_VERSION", "0.0.0")}

@app.post("/orders")
def create_order(body: OrderIn):
    oid = str(uuid.uuid4())
    ORDERS[oid] = {"id": oid, **body.model_dump()}
    return ORDERS[oid]

@app.get("/orders/{order_id}")
def get_order(order_id: str):
    if order_id not in ORDERS:
        raise HTTPException(status_code=404, detail="not found")
    return ORDERS[order_id]
