import React, { useEffect, useState } from 'react';
import { getAllProducts, deleteProduct } from '../services/ProductService';
const ProductList = () => {
const [products, setProducts] = useState([]);
useEffect(() => {
getAllProducts().then(response => {
setProducts(response.data);
});
}, []);
const handleDelete = (id) => {
deleteProduct(id).then(() => {
setProducts(products.filter(product => product.id !== id));
});
};
return (
    <div>
    <h2>Product List</h2>
    <ul>
    {products.map(product => (
    <li key={product.id}>
    {product.name} - ${product.price}
    <button onClick={() => handleDelete(product.id)}>Delete</button>
    </li>
    ))}
    </ul>
    </div>
    );
    };
    export default ProductList;