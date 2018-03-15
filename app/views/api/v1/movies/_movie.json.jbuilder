json.except! movie, :image, :video, :actor_ids
json.actors movie.actors
json.genres movie.genres
json.posters movie.images do |pic|
  json.extract! pic, :pic_file_name, :pic_content_type,
                :pic_file_size, :pic_updated_at
  json.pic_path pic.pic
end

json.videos movie.videos do |video|
  json.extract! video, :video_file_name, :video_content_type,
                :video_file_size, :video_updated_at
  json.video_path video.video
end