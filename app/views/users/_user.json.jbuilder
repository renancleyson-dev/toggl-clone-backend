# frozen_string_literal: true

json.extract! user, :id, :email, :full_name
json.projects do
  json.array! user.projects, partial: 'projects/project', as: :project
end
json.tags do
  json.array! user.tags, partial: 'tags/tag', as: :tag
end
