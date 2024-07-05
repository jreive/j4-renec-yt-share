# frozen_string_literal: true

class YoutubeVideoServiceTest < ActiveSupport::TestCase
  setup do
    @service = YoutubeVideoService.new
    @video = @service.get_info_by_url('https://www.youtube.com/watch?v=vuTY4FDAbpA')
    @video_short = @service.get_info_by_url('https://youtu.be/1mkUp1V3ys0?si=CIegx8_5o5VQjVD0')
    @video_fail = @service.get_info_by_url('http://google.com')
    @video_fail_2 = @service.get_info_by_url('https://youtu.be/1mkUp1V3ys00?si=CIegx8_5o5VQjVD0')
    @video_fail_3 = @service.get_info_by_url('https://www.youtube.com/watch?v=vuTY4FDAbpAA')
  end

  test "Should have data" do
    assert_not_nil @video
    assert_not_nil @video_short
  end

  test "Should nil if the url not correct" do
    assert_nil @video_fail
  end

  test "Should nil if the video id not exist" do
    assert_nil @video_fail_2
    assert_nil @video_fail_3
  end

  test "Should get correct data" do
    assert_equal @video[:channelId], 'UCPqrEgBEHVj4vDITrClNQIw'
    assert_equal @video_short[:channelId], 'UCDfDVqkPYdcO3WWaVwz3Scw'
  end

  test "Should contain title and thumbnail" do
    assert_not_nil @video
    assert_not_nil @video[:title]
    assert_equal true, @video[:title].length > 0
    assert_not_nil @video[:thumbnail]
    assert_equal true, @video[:thumbnail].length > 0

    assert_not_nil @video_short
    assert_not_nil @video_short[:title]
    assert_equal true, @video_short[:title].length > 0
    assert_not_nil @video_short[:thumbnail]
    assert_equal true, @video_short[:thumbnail].length > 0
  end

end
