import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../pages/Home";
import NewVideo from "../pages/NewVideo";
import Login from "../pages/Login";

export default (
    <Router>
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/videos" element={<NewVideo />} />
            <Route path="/login" element={<Login />} />
        </Routes>
    </Router>
);