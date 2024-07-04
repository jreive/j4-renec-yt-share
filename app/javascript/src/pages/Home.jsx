import React, {useEffect, useMemo, useState} from "react";
import {Link, useNavigate} from "react-router-dom";
import useUser from "../hooks/useUser";
import {debounce, fetcher} from "../helpers/CommonUtil";
import useSWR from "swr";
import VideoPagination from "../components/home/VideoPagination";
import {useSelector} from "react-redux";
import {selectVideos} from "../store/VideoReducer";
import useVideos from "../hooks/useVideos";
import VideoComponent from "../components/home/VideoComponent";
import {Button} from "react-bootstrap";

export default () => {
    const { user, email: storedEmail} = useUser();
    const navigate = useNavigate();
    const { videos, limit, page, setPage, total, error } = useVideos();

    const checkUserRedirect = useMemo(() => debounce(async (redirect) => {
        if (redirect) {
            navigate("/login");
        }
    }, 3000), []);

    useEffect(() => {
        checkUserRedirect(!user && !storedEmail);
    }, [user])

    console.log('videos', videos, page, total, error)

    return <div className="vh-100 d-flex align-items-center justify-content-center">
        <div className="jumbotron jumbotron-fluid bg-transparent">
            <div className="video-list pe-2 mt-4">
                {videos?.map(video => {
                    return <VideoComponent key={video.id} video={video}/>
                })}
            </div>
            <div className="mt-3 d-flex justify-content-between">
                <VideoPagination total={total} active={page} perPage={limit} onChange={setPage}/>
                <Button size={"sm"} className={"mb-3"}>Share a video</Button>
            </div>
        </div>
    </div>
}