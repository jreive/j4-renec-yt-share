import { createSlice, current } from '@reduxjs/toolkit';

const initialState = {
    list: [],
    unread: 0,
};

export const notificationSlice = createSlice({
    name: 'notification',
    initialState: initialState,
    reducers: {
        updateNotifications: (state, action) => {
            state.list = action.payload
            state.unread = action.payload?.filter(d => !d.read).length
        },
    }
});

export const {
    updateNotifications
} = notificationSlice.actions;

export const selectNotification = (state) => state.notification.list;
export const selectNotificationUnread = (state) => state.notification.unread;

export default notificationSlice.reducer;
