module YoutubeVideoHelper
  def map_with_user(videos)
    user_ids = videos.map(&:user_id).uniq
    users = User.where(id: user_ids).index_by(&:id)
    videos.map do |video|
      info = video.info
      info.merge({
                   email: users[info[:user_id]].public_info[:email]
                 })
    end
  end

end
