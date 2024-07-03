import { createSlice, current } from '@reduxjs/toolkit';

const initialState = {
    data: null,
};

export const userSlice = createSlice({
    name: 'user',
    initialState: initialState,
    reducers: {
        updateUser: (state, action) => {
            state.data = action.payload;
        },
        updateEmail: (state, action) => {
            state.data = {
                ...(current(state).data || {}),
                email: action.payload,
            }
        }
    }
});

export const {
    updateUser,
    updateEmail
} = userSlice.actions;

export const selectUser = (state) => state.user.data;
export const selectEmail = (state) => state.user.data?.email;

export default userSlice.reducer;
