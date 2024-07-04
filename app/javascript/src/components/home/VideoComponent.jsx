import React from 'react';
import {Card, Image} from "react-bootstrap";

const VideoComponent = ({ video, highlight }) => {
    const openVideo = () => {
        window.open(video.url);
    }

    return <Card className={`mb-2 video-component ${highlight ? 'highlight' : ''}`}>
        <Card.Body>
            <div className="d-flex video-container">
                <div className="video-image d-flex justify-content-center overflow-hidden pointer" onClick={openVideo}>
                    <Image src={video.thumb} alt={video.title}/>
                </div>
                <div className="video-info ps-3 d-flex flex-column">
                    <div className="h-100">
                        <h3 className="pointer" onClick={openVideo}>{video.title}</h3>
                        <div className="video-description-wrapper">
                            <div className="video-description">{video.description?.slice(0, 200)}{video.description?.length > 300 ? '...' : ''}</div>
                        </div>
                    </div>
                    <div className="text-end">By: {video.email}</div>
                </div>
            </div>
            {/*<Row className='justify-content-between align-items-center'>*/}
            {/*    <Col className="col-5 d-flex justify-content-center overflow-hidden">*/}
            {/*        <Image src={video.thumb} alt={video.title} />*/}
            {/*    </Col>*/}
            {/*    <Col className="col-7">*/}
            {/*        <h3>{video.title}</h3>*/}
            {/*        <div>{video.description}</div>*/}
            {/*        <div className="float-end">{video.email}</div>*/}
            {/*    </Col>*/}
            {/*</Row>*/}
        </Card.Body>
    </Card>
}

export default VideoComponent;