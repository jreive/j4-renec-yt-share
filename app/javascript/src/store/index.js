import { configureStore } from '@reduxjs/toolkit';
import userSliceReducer from './UserReducer';
import videoSliceReducer from './VideoReducer';
import notificationSliceReducer from './NotificationReducer';

export const store = configureStore({
    reducer: {
        user: userSliceReducer,
        video: videoSliceReducer,
        notification: notificationSliceReducer,
    },
});
