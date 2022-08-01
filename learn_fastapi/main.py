from enum import Enum
from fastapi import FastAPI

app = FastAPI()

class ModelName(str, Enum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"

@app.get("/")
async def home():
    return {"message": "Hello World"}

@app.get("/users/me")
async def read_user():
    return {"my user id" : "me"}

@app.get("/users/{user_id}")
async def read_user_id(user_id: str):
    return {"user_id" : user_id}

@app.get("/models/{model_name}")
async def get_model(model_name: ModelName):
    print(model_name)
    if model_name == ModelName.alexnet:
        return {"model_name" : model_name, "message": "This model is alexnet"}  
    elif model_name.value == "resnet":
        return {"model_name" : model_name, "message": "This model is resnet"}  
    elif model_name == ModelName.lenet:
        return {"model_name" : model_name, "message": "This model is lenet"}  
    else:
        return {"model_name" : model_name, "message": "ETC model"}  