import useSWR from 'swr';
import {fetcher} from "../helpers/CommonUtil";
import {useDispatch, useSelector} from 'react-redux';
import {useEffect, useState} from "react";
import {selectTotalVideo, selectVideos, updateTotalVideo, updateVideos} from "../store/VideoReducer";

export default function useVideos() {
    const dispatch = useDispatch();
    const storedVideos = useSelector(selectVideos);
    const [currentVideos, setCurrentVideos] = useState([]);
    const [page, setPage] = useState(1);
    const [limit, setLimit] = useState(10);
    const total = useSelector(selectTotalVideo);

    const updateVideoCallback = (payload) => {
        dispatch(updateVideos(payload?.videos || []))
        dispatch(updateTotalVideo(payload?.total || 0))
    }

    const { data: videos, mutate: mutateVideos, error } = useSWR('/api/videos', (url) => {
        return fetcher(url, {
            limit,
            page,
        }, 'GET').then(r => r.json()).then(response => {
            updateVideoCallback(response.data)
            return response.data;
        })
    }, {
        revalidateOnFocus: false
    });

    useEffect(() => {
        setCurrentVideos(storedVideos);
    }, [storedVideos]);

    useEffect(() => {
        mutateVideos();
    }, [page])

    if (!videos || videos?.error) {
        if (videos?.error) {
            dispatch(updateVideos([]));
        }
        return { videos: [], mutateVideos, page, setPage, limit, setLimit, total, error }
    }

    return { videos: currentVideos, mutateVideos, page, setPage, limit, setLimit, total, error }
}