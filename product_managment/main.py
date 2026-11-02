from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session

import models
from database import engine, get_db


models.Base.metadata.create_all(bind=engine)


app = FastAPI(
    title="Product Management API",
    description="A practical FastAPI project demonstrating HTTP methods",
    version="1.0.0"
)


class ProductCreate(BaseModel):
    name: str
    description: str
    price: int
    quantity: int


class ProductUpdate(BaseModel):
    name: str | None = None
    description: str | None = None
    price: int | None = None
    quantity: int | None = None


@app.get("/")
def home():
    return {
        "message": "Welcome To Product Management API"
    }


@app.get("/products")
def get_products(db: Session = Depends(get_db)):

    products = db.query(models.Product).all()

    return {
        "products": products
    }


@app.get("/products/{product_id}")
def get_product(
    product_id: int,
    db: Session = Depends(get_db)
):

    product = db.query(models.Product).filter(
        models.Product.id == product_id
    ).first()

    if product is None:
        raise HTTPException(
            status_code=404,
            detail="Product ID not found"
        )

    return product


@app.post("/products", status_code=201)
def create_product(
    product: ProductCreate,
    db: Session = Depends(get_db)
):

    new_product = models.Product(
        name=product.name,
        description=product.description,
        price=product.price,
        quantity=product.quantity
    )

    db.add(new_product)
    db.commit()
    db.refresh(new_product)

    return {
        "message": "Product created successfully",
        "product_id": new_product.id,
        "product": new_product
    }


@app.put("/products/{product_id}")
def update_product(
    product_id: int,
    product: ProductCreate,
    db: Session = Depends(get_db)
):

    existing_product = db.query(models.Product).filter(
        models.Product.id == product_id
    ).first()

    if existing_product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    existing_product.name = product.name
    existing_product.description = product.description
    existing_product.price = product.price
    existing_product.quantity = product.quantity

    db.commit()
    db.refresh(existing_product)

    return {
        "message": "Product completely updated",
        "product_id": product_id,
        "product": existing_product
    }


@app.patch("/products/{product_id}")
def partial_update_product(
    product_id: int,
    product: ProductUpdate,
    db: Session = Depends(get_db)
):

    existing_product = db.query(models.Product).filter(
        models.Product.id == product_id
    ).first()

    if existing_product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    update_data = product.model_dump(
        exclude_unset=True
    )

    for field, value in update_data.items():
        setattr(existing_product, field, value)

    db.commit()
    db.refresh(existing_product)

    return {
        "message": "Product partially updated",
        "product_id": product_id,
        "product": existing_product
    }


@app.delete("/products/{product_id}")
def delete_product(
    product_id: int,
    db: Session = Depends(get_db)
):

    existing_product = db.query(models.Product).filter(
        models.Product.id == product_id
    ).first()

    if existing_product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    db.delete(existing_product)
    db.commit()

    return {
        "message": "Product deleted successfully",
        "product_id": product_id
    }