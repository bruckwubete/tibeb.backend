json.status 'success'
json.data do
  json.except! @resource, :profile_pic_file_name, :profile_pic_content_type,
               :profile_pic_file_size, :profile_pic_updated_at, :profile_pic_fingerprint, :tokens, :encrypted_password
  json.profile_pic do
    json.extract! @resource, :profile_pic_file_name, :profile_pic_content_type,
                :profile_pic_file_size, :profile_pic_updated_at, :profile_pic_fingerprint
    json.profile_pic_path @resource.profile_pic
  end
end