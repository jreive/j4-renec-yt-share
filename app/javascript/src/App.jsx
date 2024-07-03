import React from "react";
import Routes from "./routes";
import {store} from "./store";
import DefaultLayout from "./components/DefaultLayout";
import {Provider} from "react-redux";

export default props => <>
    <Provider store={store}>
        <DefaultLayout>{Routes}</DefaultLayout>
    </Provider>
</>;