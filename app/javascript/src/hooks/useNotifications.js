import useSWR from 'swr';
import {fetcher} from "../helpers/CommonUtil";
import {useDispatch, useSelector} from 'react-redux';
import {useEffect, useState} from "react";
import {selectTotalVideo, selectVideos, updateTotalVideo, updateVideos} from "../store/VideoReducer";
import {
    readAll,
    readNotification,
    selectNotification,
    selectNotificationUnread,
    updateNotifications
} from "../store/NotificationReducer";

export default function useNotifications() {
    const dispatch = useDispatch();
    const storedNotification = useSelector(selectNotification);
    const storedUnread = useSelector(selectNotificationUnread);
    const [currentNotification, setCurrentNotification] = useState([]);

    const updateNotificationCallback = (payload) => {
        dispatch(updateNotifications(payload || []))
    }

    const markReadNotification = async (id) => {
        const notification = currentNotification.find(c => c.id === id);
        if (notification && !notification.read) {
            dispatch(readNotification(id))
            await fetcher('/api/notifications/read', {
                id,
            }, 'POST')
        }
    }

    const markReadAll = async () => {
        dispatch(readAll())
        await fetcher('/api/notifications/read-all', {}, 'POST')
    }

    const { data: notification, mutate: mutateNotification, error } = useSWR('/api/notifications', (url) => {
        return fetcher(url, {}, 'GET').then(r => r.json()).then(response => {
            updateNotificationCallback(response.data)
            return response.data;
        })
    }, {
        revalidateOnFocus: false
    });

    useEffect(() => {
        setCurrentNotification(storedNotification);
    }, [storedNotification]);

    if (!notification || notification?.error) {
        if (notification?.error) {
            dispatch(updateVideos([]));
        }
        return { notification: [], unread: 0, mutateNotification, markReadNotification, markReadAll, error }
    }

    return { notification: currentNotification, unread: storedUnread, mutateNotification, markReadNotification, markReadAll, error }
}