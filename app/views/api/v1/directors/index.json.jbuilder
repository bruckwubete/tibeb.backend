json.data {json.array! @directors, partial: 'api/v1/directors/director', as: :director}
json.metadata do
  json.total_count @directors.length
  json.current_page @directors.current_page
  json.last_page @directors.total_pages
  json.page_size @directors.limit_value
end