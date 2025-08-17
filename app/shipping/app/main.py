from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os, uuid

app = FastAPI(title="shipping", version=os.getenv("SERVICE_VERSION", "0.0.0"))

class ShipmentReq(BaseModel):
    order_id: str
    address: str

SHIPMENTS: dict[str, dict] = {}

@app.get("/healthz")
def healthz(): return {"status": "ok"}

@app.get("/readyz")
def readyz(): return {"ready": True}

@app.get("/version")
def version(): return {"name": "shipping", "version": os.getenv("SERVICE_VERSION", "0.0.0")}

@app.post("/shipments")
def create_shipment(req: ShipmentReq):
    sid = str(uuid.uuid4())
    SHIPMENTS[sid] = {"id": sid, "status": "created", **req.model_dump()}
    return SHIPMENTS[sid]

@app.get("/shipments/{sid}")
def get_shipment(sid: str):
    if sid not in SHIPMENTS:
        raise HTTPException(status_code=404, detail="not found")
    return SHIPMENTS[sid]
