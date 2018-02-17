json.except! movie, :picture
json.picture_info do
  json.extract! movie, :picture_file_name, :picture_content_type,
                      :picture_file_size, :picture_updated_at
  json.picture_path movie.picture
end