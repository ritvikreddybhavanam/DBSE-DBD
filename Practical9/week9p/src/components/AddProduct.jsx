import React, { useState } from 'react';
import { addProduct } from '../services/ProductService';
const AddProduct = () => {
const [product, setProduct] = useState({ name: '', description: '', price: '', quantity: '' });
const handleChange = (e) => {
setProduct({ ...product, [e.target.name]: e.target.value });
};
const handleSubmit = (e) => {
e.preventDefault();
addProduct(product).then(() => {
alert("Product added successfully!");
});
};
return (
<form onSubmit={handleSubmit}>
<input type="text" name="name" placeholder="Name" onChange={handleChange} required />
<input type="text" name="description" placeholder="Description" onChange={handleChange} />
<input type="number" name="price" placeholder="Price" onChange={handleChange} required />
<input type="number" name="quantity" placeholder="Quantity" onChange={handleChange} required />
<button type="submit">Add Product</button>
</form>
);
};
export default AddProduct;