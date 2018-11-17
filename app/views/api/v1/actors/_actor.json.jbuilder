json.except! actor, :images, :videos, :_id

json.id actor.id.to_s

json.pictures actor.images do |pic|
  json.extract! pic, :pic_file_name, :pic_content_type,
                :pic_file_size, :pic_updated_at
  json.pic_path pic.pic
end

json.videos actor.videos do |vid|
  json.extract! vid, :video_file_name, :video_content_type, :video_file_size, :video_updated_at
  json.video_path vid.video
end