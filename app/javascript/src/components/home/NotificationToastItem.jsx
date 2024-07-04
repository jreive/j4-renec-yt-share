import {Toast, ToastContainer} from "react-bootstrap";
import React, {useState} from "react";

const NotificationToastItem = ({ title = 'New video!', time = 'Just now', text, onClose }) => {
    const [show, setShow] = useState(true);

    return <Toast onClose={() => {
        setShow(false)
        onClose()
    }} show={show} delay={7000} autohide>
        <Toast.Header closeButton={true}>
            <strong className="me-auto">{title}</strong>
            <small>{time}</small>
        </Toast.Header>
        <Toast.Body>{text}</Toast.Body>
    </Toast>
}

export default NotificationToastItem