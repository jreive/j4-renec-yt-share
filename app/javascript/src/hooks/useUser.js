import { useMemo, useRef } from 'react';
import useSWR from 'swr';

const KEY_TOKEN = "access_token";
export default function useUser() {
    // eslint-disable-next-line react-hooks/exhaustive-deps
    const accessToken = localStorage.getItem(KEY_TOKEN);
    const { data: user, mutate: mutateUser } = useSWR(accessToken ? '/api/user/validate' : null, (url) => {
        return fetch(url).then(r => r.json())
    });

    console.log(user)
    if (!user || !user.data || user.status !== '1') {
        if (user && (user.status === 'error' && user.errorCode === '403')) {
            localStorage.removeItem(KEY_TOKEN);
        }
        return { user: null, mutateUser }
    }

    return { user, mutateUser }
}