import React from 'react';
import Header from "./Header";
import Footer from "./Footer";

const DefaultLayout = ({ children }) => {
    return <div className="outbound-container d-flex h-100 p-3 mx-auto flex-column">
        <Header />
        { children }
        <Footer />
    </div>
}

export default DefaultLayout;