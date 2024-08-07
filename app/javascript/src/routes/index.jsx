import React from "react";
import {BrowserRouter as Router, Routes, Route, Navigate} from "react-router-dom";
import Home from "../pages/Home";
import Login from "../pages/Login";

export default (
    <Router>
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login />} />
            <Route path="*" element={<Navigate to="/" replace={true} />} />
        </Routes>
    </Router>
);