
class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis(  'v1' => {
    controller_base_path: '',
    api_file_path: 'public/apidocs',
    base_path: 'http://tibeb-back-bruck.c9users.io/',
    clean_directory: true
  })
