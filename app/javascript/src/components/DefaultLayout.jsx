import React from 'react';
import Header from "./Header";
import Footer from "./Footer";

const DefaultLayout = ({ children }) => {
    return <div className="outbound-container d-flex h-100 p-3 mx-auto flex-column">
        <Header />

        {/*<main role="main" className="inner cover">*/}
        {/*    <h1 className="cover-heading">Cover your page.</h1>*/}
        {/*    <p className="lead">Cover is a one-page template for building simple and beautiful home pages. Download,*/}
        {/*        edit the text, and add your own fullscreen background photo to make it your own.</p>*/}
        {/*    <p className="lead">*/}
        {/*        <a href="#" className="btn btn-lg btn-secondary">Learn more</a>*/}
        {/*    </p>*/}
        {/*</main>*/}

        { children }

        <Footer />
    </div>
}

export default DefaultLayout;