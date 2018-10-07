json.data {json.array! @people, partial: 'api/v1/people/person', as: :person}
json.metadata do
  json.total_count @people.length
  json.current_page @people.current_page
  json.last_page @people.total_pages
  json.page_size @people.limit_value
end