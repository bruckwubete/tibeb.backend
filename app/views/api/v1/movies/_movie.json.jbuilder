json.except! movie, :images, :videos, :actor_ids, :genre_ids, :crew_ids, :director_ids, :writer_ids, :_id

json.id movie.id.to_s

json.images movie.images do |pic|
  json.extract! pic, :pic_file_name, :pic_content_type,
                :pic_file_size, :pic_updated_at
  json.pic_path pic.pic
end

json.videos movie.videos do |vid|
  json.extract! vid, :video_file_name, :video_content_type, :video_file_size, :video_updated_at
  json.video_path vid.video
end


json.actors {json.array! movie.actors, partial: 'api/v1/actors/actor', as: :actor}
json.directors {json.array! movie.directors, partial: 'api/v1/directors/director', as: :director}
json.crews {json.array! movie.crews, partial: 'api/v1/crews/crew', as: :crew}
json.writers {json.array! movie.writers, partial: 'api/v1/writers/writer', as: :writer}

json.genres movie.genres

