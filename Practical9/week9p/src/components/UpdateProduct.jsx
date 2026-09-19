import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { updateProduct, getAllProducts } from "../services/ProductService";
const UpdateProduct = () => {
const { id } = useParams(); // Get product ID from route params
const navigate = useNavigate();
const [product, setProduct] = useState({
    name: "",
    description: "",
    price: 0,
    quantity: 0,
    });
    // Fetch product details when component mounts
    useEffect(() => {
    getAllProducts().then((response) => {
    const productData = response.data.find((p) => p.id.toString() === id);
    if (productData) {
    setProduct(productData);
    }
    });
    }, [id]);
    const handleChange = (e) => {
    setProduct({ ...product, [e.target.name]: e.target.value });
    };
    const handleSubmit = async (e) => {
    e.preventDefault();
    try {
    await updateProduct(id, product);
    alert("Product updated successfully!");
    navigate("/"); // Redirect to product list
    } catch (error) {
    console.error("Error updating product:", error);
    alert("Failed to update product");
    }
    };
    return (
    <div>
    <h2>Update Product</h2>
    <form onSubmit={handleSubmit}>
    <label>Name:</label>
    <input type="text" name="name" value={product.name} onChange={handleChange} required />
    <label>Description:</label>
    <input type="text" name="description" value={product.description} onChange={handleChange} required />
    <label>Price:</label>
    <input type="number" name="price" value={product.price} onChange={handleChange} required />
    <label>Quantity:</label>
    <input type="number" name="quantity" value={product.quantity} onChange={handleChange} required />
    <button type="submit">Update Product</button>
    </form>
    </div>
    );
    };
    export default UpdateProduct;