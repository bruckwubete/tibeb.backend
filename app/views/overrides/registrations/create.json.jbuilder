json.status 'success'
json.data do
  json.except! @resource, :tokens, :encrypted_password

  json.images @resource.images do |image|
    json.extract! image, :pic_file_name, :pic_content_type,
                  :pic_file_size, :pic_updated_at, :pic_fingerprint
    json.path image.pic
  end
end
