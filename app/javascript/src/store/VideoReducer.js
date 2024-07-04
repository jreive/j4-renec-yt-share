import { createSlice, current } from '@reduxjs/toolkit';

const initialState = {
    videos: [],
    total: 0,
};

export const videoSlice = createSlice({
    name: 'video',
    initialState: initialState,
    reducers: {
        updateVideos: (state, action) => {
            state.videos = action.payload
        },
        updateTotalVideo: (state, action) => {
            state.total = action.payload
        },
        addVideo: (state, action) => {
            state.videos = [
                ...(current(state).videos || []),
                action.payload,
            ]
        }
    }
});

export const {
    updateVideos,
    addVideo,
    updateTotalVideo
} = videoSlice.actions;

export const selectVideos = (state) => state.video.videos;
export const selectTotalVideo = (state) => state.video.total;

export default videoSlice.reducer;
