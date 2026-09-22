import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import ProductList from "./components/ProductList";
import AddProduct from "./components/AddProduct";
import UpdateProduct from "./components/UpdateProduct";
import DeleteProduct from "./components/DeleteProduct";
const App = () => {
return (
<Router>
<Routes>
<Route path="/" element={<ProductList />} />
<Route path="/add" element={<AddProduct />} />
<Route path="/update/:id" element={<UpdateProduct />} />
<Route path="/delete/:id" element={<DeleteProduct />} />
</Routes>
</Router>
);
};
export default App;