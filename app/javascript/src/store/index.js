import { configureStore } from '@reduxjs/toolkit';
import userSliceReducer from './UserReducer';

export const store = configureStore({
    reducer: {
        user: userSliceReducer
    },
});
