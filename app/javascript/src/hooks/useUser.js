import useSWR from 'swr';
import {KEY_TOKEN} from "../constants";
import {fetcher} from "../helpers/CommonUtil";
import { useDispatch, useSelector } from 'react-redux';
import {selectEmail, selectUser, updateEmail, updateUser} from "../store/UserReducer";
import {useEffect, useState} from "react";

export default function useUser() {
    const dispatch = useDispatch();
    const storedUser = useSelector(selectUser);
    const storedEmail = useSelector(selectEmail);
    const [currentUser, setCurrentUser] = useState();

    const accessToken = localStorage.getItem(KEY_TOKEN);

    const updateUserCallback = (payload) => {
        dispatch(updateUser(payload));
    }

    const { data: user, mutate: mutateUser } = useSWR(accessToken ? '/api/user/validate' : null, (url) => {
        return fetcher(url, {}, 'POST').then(r => r.json()).then(response => {
            updateUserCallback(response.data);
            return response
        })
    });

    useEffect(() => {
        setCurrentUser(storedUser);
    }, [storedUser]);

    if (!user || user?.error) {
        if (user?.error) {
            localStorage.removeItem(KEY_TOKEN);
            dispatch(updateUser(null));
        }
        return { user: null, email: null, mutateUser, updateUser: updateUserCallback }
    }

    return { user: currentUser, email: storedEmail, mutateUser, updateUser: updateUserCallback }
}