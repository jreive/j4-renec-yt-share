import React, {useEffect, useMemo, useState} from "react";
import {useNavigate} from "react-router-dom";
import useUser from "../hooks/useUser";
import {debounce} from "../helpers/CommonUtil";
import VideoPagination from "../components/home/VideoPagination";
import useVideos from "../hooks/useVideos";
import VideoComponent from "../components/home/VideoComponent";
import {Button} from "react-bootstrap";
import useNotifications from "../hooks/useNotifications";
import consumer from "../channels/consumer";
import NotificationToast from "../components/home/NotificationToast";
import {KEY_TOKEN} from "../constants";

export default () => {
    const { user, email: storedEmail} = useUser();
    const { notification, mutateNotification } = useNotifications();
    const navigate = useNavigate();
    const { videos, limit, page, setPage, total, mutateVideos, error } = useVideos();
    const [newToast, setNewToast] = useState();

    const checkUserRedirect = useMemo(() => debounce(async (redirect) => {
        if (redirect) {
            navigate("/login");
        }
    }, 1000), []);

    useEffect(() => {
        const access = localStorage.getItem(KEY_TOKEN)
        if (!access) {
            navigate('/login')
        } else {
            checkUserRedirect(!user && !storedEmail);
        }
    }, [user])

    const unreadVideos = useMemo(() => {
        return notification?.filter(n => !n.read).map(n => n.video.id) || []
    }, [notification])

    useEffect(() => {
        consumer.subscriptions.create({ channel: "NotificationsChannel" }, {
            received(data) {
                setNewToast(data)
                mutateVideos();
                mutateNotification();
            }
        })
        return () => {
            // reload
        }
    }, []);

    return <div className="vh-100 d-flex align-items-center justify-content-center">
        <div className="w-100 jumbotron jumbotron-fluid bg-transparent">
            <div className="video-list pe-2 mt-4">
                {videos?.map(video => {
                    return <VideoComponent key={video.id} video={video} highlight={unreadVideos.includes(video.id)}/>
                })}
            </div>
            <div className="mt-3 d-flex justify-content-between">
                <VideoPagination total={total} active={page} perPage={limit} onChange={setPage}/>
                <Button size={"sm"} className={"mb-3"}>Share a video</Button>
            </div>
            <NotificationToast newToast={newToast} user={user} />
        </div>
    </div>
}