import {Toast, ToastContainer} from "react-bootstrap";
import React, {useEffect, useState} from "react";
import NotificationToastItem from "./NotificationToastItem";

const NotificationToast = ({ newToast, user }) => {
    const [toastList, setToastList] = useState([]);

    useEffect(() => {
        if (newToast && newToast.user_id !== user?.id) {
            setToastList(p => [...p, newToast]);
        }
    }, [newToast])

    return <ToastContainer
        className="p-3"
        position={"bottom-end"}
        style={{ zIndex: 1 }}
    >
        {toastList.map(data => {
            return <NotificationToastItem key={data.id} text={`${data.email} just posted video ${data.title}`} onClose={() => {
                const newList = toastList.filter(t => t.id !== data.id)
                setToastList(newList);
            }} />
        })}
    </ToastContainer>
}
export default NotificationToast