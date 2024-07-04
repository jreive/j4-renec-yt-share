import {Toast, ToastContainer} from "react-bootstrap";
import React, {useEffect, useState} from "react";
import NotificationToastItem from "./NotificationToastItem";

const NotificationToast = ({ newToast }) => {
    const [toastList, setToastList] = useState([]);

    useEffect(() => {
        console.log('new toast', newToast, toastList)
        if (newToast) {
            setToastList(p => [...p, newToast]);
        }
    }, [newToast])

    console.log(toastList)
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