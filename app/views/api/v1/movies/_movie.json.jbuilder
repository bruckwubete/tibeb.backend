json.except! movie, :picture, :video
json.posters movie.posters do |picture|
  json.extract! picture, :picture_file_name, :picture_content_type,
                :picture_file_size, :picture_updated_at
  json.picture_path picture.picture
end

json.videos movie.videos do |video|
  json.extract! video, :video_file_name, :video_content_type,
                :video_file_size, :video_updated_at
  json.video_path video.video
end