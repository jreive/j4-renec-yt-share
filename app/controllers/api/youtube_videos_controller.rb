class Api::YoutubeVideosController < ApplicationController
  def index
    exercise = YoutubeVideo.all.order(created_at: :desc)
    render json: exercise
  end

  def create
    video = YoutubeVideo.create!(yt_params)
    if video
      render json: video
    else
      render json: video.errors
    end
  end

  def show
  end

  private
  def yt_params
    params.permit(:url, :title, :html, :thumb)
  end
end
