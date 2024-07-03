import React from 'react';
import useUser from "../../hooks/useUser";

const Header = () => {
    const { user } = useUser();

    console.log(user)
    return <header className="custom-header mb-auto text-center">
        <div className="inner">
            <h3 className="brand-name m-0">Cover</h3>
            <nav className="nav nav-header justify-content-center">
                <a className="nav-link active" href="#">Home</a>
                <a className="nav-link" href="#">Features</a>
                <a className="nav-link" href="#">Contact</a>
            </nav>
        </div>
    </header>
}

export default Header;