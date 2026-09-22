import React from "react";
import { useNavigate, useParams } from "react-router-dom";
import { deleteProduct } from "../services/ProductService";
const DeleteProduct = () => {
const { id } = useParams(); // Get product ID from URL params
const navigate = useNavigate();
const handleDelete = async () => {
try {
await deleteProduct(id);
alert("Product deleted successfully!");
navigate("/"); // Redirect to product list
} catch (error) {
console.error("Error deleting product:", error);
alert("Failed to delete product");
}
};
return (
<div>
<h2>Are you sure you want to delete this product?</h2>
<button onClick={handleDelete}>Yes, Delete</button>
<button onClick={() => navigate("/")}>Cancel</button>
</div>
);
};
export default DeleteProduct;