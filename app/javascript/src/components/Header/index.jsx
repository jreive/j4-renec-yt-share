import React from 'react';
import useUser from "../../hooks/useUser";
import {useSelector} from "react-redux";
import {selectEmail} from "../../store/UserReducer";

const Header = () => {
    const email = useSelector(selectEmail);

    console.log(email)
    return <header className="custom-header mb-auto text-center">
        <div className="inner">
            <h3 className="brand-name m-0">Cover</h3>
            <nav className="nav nav-header align-items-center justify-content-center">
                {email ? <>
                    <div className="nav-link">Hi, {email}</div>
                    <div className="nav-link active">Share video</div>
                    <div className="nav-link">Logout</div>
                </> : <>
                    <div className="nav-link active">Login/Register</div>
                </>}
            </nav>
        </div>
    </header>
}

export default Header;