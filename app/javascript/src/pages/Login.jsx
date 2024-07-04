import React, {useEffect, useMemo, useRef, useState} from "react";
import {Link, useNavigate } from "react-router-dom";
import {Alert, Button, Form} from "react-bootstrap"
import {debounce, delay, fetcher} from "../helpers/CommonUtil";
import {KEY_TOKEN} from "../constants";
import useUser from "../hooks/useUser";
import {useDispatch} from "react-redux";

export default () => {
    const { user, email: storedEmail, updateUser } = useUser();
    const navigate = useNavigate();

    const email = useRef('');
    const password = useRef('');
    const [errorMessage, setErrorMessage] = useState('');
    const [registerMode, setRegisterMode] = useState(false);
    const [checkingMail, setCheckingMail] = useState(false);

    const [loading, setLoading] = useState(false);

    const handleSubmit = async (event) => {
        event.preventDefault();
        setLoading(true);
        await fetcher( registerMode ? "/signup" : "/login", {
            user: { email: email.current, password: password.current }
        }, "POST").then(async r => {
            const response = await r.json();
            if (response.error || response.status?.error) {
                setErrorMessage(response.error || response.status?.error);
            } else if (response.data?.id) {
                localStorage.setItem(KEY_TOKEN, r.headers.get("Authorization"));
                updateUser(response.data);
                navigate("/");
            }
        }).catch(r => {
            setErrorMessage(r.message || 'Unknown error');
        }).finally(() => {
            setLoading(false);
        })
    };

    useEffect(() => {
        if (user && storedEmail) {
            navigate("/");
        }
    }, [user]);

    const checkEmail = useMemo(() => debounce(async (mail) => {
        if (!mail) return;
        await fetcher("/api/user/check", {
            email: mail,
        }, "POST").then(r => r.json()).then(response => {
            if (response.error) {
                setErrorMessage(response.error)
            } else {
                setErrorMessage('');
            }
        }).finally(() => {
            setCheckingMail(false);
        })
    }, 700), []);

    const handleEmail = (e) => {
        email.current = e.target.value
        if (registerMode) {
            setCheckingMail(true)
            checkEmail(e.target.value);
        }
    }

    return (
        <div>
            <Form className="shadow p-4 rounded" onSubmit={handleSubmit}>
                <div className="h4 mb-2 text-center">Sign In</div>
                {errorMessage && <Alert
                    className="mb-2"
                    variant="danger"
                    onClose={() => setErrorMessage('')}
                    dismissible
                >
                    {errorMessage}
                </Alert>}
                <Form.Group className="mb-2" controlId="username">
                    <Form.Label>Email</Form.Label>
                    <Form.Control
                        type="email"
                        defaultValue={email.current}
                        placeholder="Email"
                        onChange={handleEmail}
                        required
                    />
                </Form.Group>
                <Form.Group className="mb-2" controlId="password">
                    <Form.Label>Password</Form.Label>
                    <Form.Control
                        type="password"
                        defaultValue={password.current}
                        placeholder="Password"
                        onChange={(e) => password.current = e.target.value}
                        required
                    />
                </Form.Group>
                <Button className="w-100 mt-3" variant="primary" type="submit" disabled={loading || checkingMail || errorMessage}>
                    {!loading ? (registerMode ? 'Sign up' : 'Log In') : '...'}
                </Button>
                <hr/>
                {!registerMode ? <div>Don't have account? <span className="text-decoration-underline pointer" onClick={() => {
                    setRegisterMode(true);
                }}>Sign up for an account now</span></div> : <div className="text-decoration-underline pointer"  onClick={() => setRegisterMode(false)}>
                    Back to login
                </div>}
            </Form>
        </div>
    );
}