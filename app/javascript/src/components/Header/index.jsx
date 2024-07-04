import React from 'react';
import useUser from "../../hooks/useUser";
import {useDispatch, useSelector} from "react-redux";
import {selectEmail, updateUser} from "../../store/UserReducer";
import {fetcher} from "../../helpers/CommonUtil";
import {KEY_TOKEN} from "../../constants";
import {useLocation, useNavigate} from "react-router-dom";
import {readAll, selectNotificationUnread} from "../../store/NotificationReducer";
import useNotifications from "../../hooks/useNotifications";

const Header = () => {
    const email = useSelector(selectEmail);
    const dispatch = useDispatch();
    const { unread: storedUnread, markReadAll } = useNotifications();

    return <header className="custom-header mb-auto text-center">
        <div className="inner">
            <h3 className="brand-name m-0">Cover Me!</h3>
            <nav className="nav nav-header align-items-center justify-content-center">
                {email ? <>
                    <div className="nav-link my-mail pointer" onClick={() => {
                        markReadAll()
                    }}>Hi, {email} {storedUnread > 0 && <span>{storedUnread}</span>}</div>
                    <div className={`nav-link ${window?.location.pathname === '/' ? 'active' : ''}`}>Shared video</div>
                    {/*<div className={`nav-link ${window?.location.pathname === '/me' ? 'active' : ''}`}>My video</div>*/}
                    <div className="nav-link pointer" onClick={async () => {
                        await fetcher('/logout', {}, 'DELETE').finally(() => {
                            localStorage.removeItem(KEY_TOKEN);
                            dispatch(updateUser(null));
                        })
                    }}>Logout</div>
                </> : <>
                    <div className="nav-link active">Login/Register</div>
                </>}
            </nav>
        </div>
    </header>
}

export default Header;