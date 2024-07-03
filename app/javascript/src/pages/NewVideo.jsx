import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

const NewVideo = () => {
    const navigate = useNavigate();
    const [url, setUrl] = useState();
    const [title, setTitle] = useState();
    const [html, setHtml] = useState();
    const [thumb, setThumb] = useState();

    const onChange = (event, setFunction) => {
        setFunction(event.target.value);
    };

    const onSubmit = (event) => {
        event.preventDefault();
        const url = "/api/youtube_videos/create";

        const body = {
            url, title, html: stripHtmlEntities(html), thumb
        };

        const token = document.querySelector('meta[name="csrf-token"]').content;
        fetch(url, {
            method: "POST",
            headers: {
                "X-CSRF-Token": token,
                "Content-Type": "application/json",
            },
            body: JSON.stringify(body),
        })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then((response) => navigate(`/exercises/${response.id}`))
            .catch((error) => console.log(error.message));
    };

    return (
        <div className="container mt-5">
            <div className="row">
                <div className="col-sm-12 col-lg-6 offset-lg-3">
                    <h1 className="font-weight-normal mb-5">
                        Add a new exercise to our exercise collection.
                    </h1>
                    <form onSubmit={onSubmit}>
                        <div className="form-group">
                            <label htmlFor="videoUrl">URL</label>
                            <input
                                type="text"
                                name="url"
                                id="videoUrl"
                                className="form-control"
                                required
                                onChange={(event) => onChange(event, setUrl)}
                            />
                        </div>
                        {/*<div className="form-group">*/}
                        {/*    <label htmlFor="exercisetraining">Trainings</label>*/}
                        {/*    <input*/}
                        {/*        type="text"*/}
                        {/*        name="trainings"*/}
                        {/*        id="exerciseTrainings"*/}
                        {/*        className="form-control"*/}
                        {/*        required*/}
                        {/*        onChange={(event) => onChange(event, setTrainings)}*/}
                        {/*    />*/}
                        {/*    <small id="trainingsHelp" className="form-text text-muted">*/}
                        {/*        Separate each training with a comma.*/}
                        {/*    </small>*/}
                        {/*</div>*/}
                        {/*<label htmlFor="instruction">Preparation Instructions</label>*/}
                        {/*<textarea*/}
                        {/*    className="form-control"*/}
                        {/*    id="instruction"*/}
                        {/*    name="instruction"*/}
                        {/*    rows="5"*/}
                        {/*    required*/}
                        {/*    onChange={(event) => onChange(event, setInstruction)}*/}
                        {/*/>*/}
                        <button type="submit" className="btn custom-button mt-3">
                            Create Exercise
                        </button>
                        <Link to="/exercises" className="btn btn-link mt-3">
                            Back to exercises
                        </Link>
                    </form>
                </div>
            </div>
        </div>
    );
};

const stripHtmlEntities = (str) => {
    return String(str)
        .replace(/\n/g, "<br> <br>")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
};

export default NewVideo;