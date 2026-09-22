from fastapi import FastAPI, HTTPException
from pydantic import BaseModel


app = FastAPI(
    title="Product Management API",
    description="A practical FastAPI project demonstrating HTTP methods",
    version="1.0.0"
)


class Product(BaseModel):
    name: str
    description: str
    price: int
    quantity: int


class ProductUpdate(BaseModel):
    name: str | None = None
    description: str | None = None
    price: int | None = None
    quantity: int | None = None


products = {}


@app.get("/")
def home():
    return {
        "message": "Welcome To Product Management API"
    }


@app.get("/products")
def get_products():
    return {
        "products": products
    }


@app.get("/products/{product_id}")
def get_product(product_id: int):

    if product_id not in products:
        raise HTTPException(
            status_code=404,
            detail="Product ID not found"
        )

    return products[product_id]


@app.post("/products", status_code=201)
def create_product(product_id: int, product: Product):

    if product_id in products:
        raise HTTPException(
            status_code=400,
            detail="Product ID already exists"
        )

    products[product_id] = product.model_dump()

    return {
        "message": "Product created successfully",
        "product_id": product_id,
        "product": products[product_id]
    }


@app.put("/products/{product_id}")
def update_product(product_id: int, product: Product):

    if product_id not in products:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    products[product_id] = product.model_dump()

    return {
        "message": "Product completely updated",
        "product_id": product_id,
        "product": products[product_id]
    }


@app.patch("/products/{product_id}")
def partial_update_product(
    product_id: int,
    product: ProductUpdate
):

    if product_id not in products:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    update_data = product.model_dump(
        exclude_unset=True
    )

    products[product_id].update(update_data)

    return {
        "message": "Product partially updated",
        "product_id": product_id,
        "product": products[product_id]
    }


@app.delete("/products/{product_id}")
def delete_product(product_id: int):

    if product_id not in products:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    deleted_product = products.pop(product_id)

    return {
        "message": "Product deleted successfully",
        "product_id": product_id,
        "product": deleted_product
    }