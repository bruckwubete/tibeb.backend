json.data {json.array! @movies, partial: 'api/v1/movies/movie', as: :movie}

json.metadata do
  json.total_count @movies.length
  json.current_page @movies.current_page
  json.last_page @movies.total_pages
  json.page_size @movies.limit_value
  json.links do
    json.next "?page[number]=#{@movies.next_page}&page[size]=#{@movies.limit_value}"
    json.self "?page[number]=#{@movies.current_page}&page[size]=#{@movies.limit_value}"
    json.prev "?page[number]=#{@movies.prev_page}&page[size]=#{@movies.limit_value}"
  end
end