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
        readNotification: (state, action) => {
            const oldList = current(state).list
            const oldIndex = oldList.findIndex(n => n.id === action.payload);
            if (oldIndex !== -1) {
                oldList[oldIndex].read = true;
                state.list = [
                    ...oldList
                ]
                state.unread = oldList.filter(d => !d.read).length
            }
        },
        readAll: (state, action) => {
            state.list = current(state).list.map(n => ({
                ...n,
                read: true
            }))
            state.unread = 0;
        }
    }
});

export const {
    updateNotifications,
    readNotification,
    readAll
} = notificationSlice.actions;

export const selectNotification = (state) => state.notification.list;
export const selectNotificationUnread = (state) => state.notification.unread;

export default notificationSlice.reducer;
