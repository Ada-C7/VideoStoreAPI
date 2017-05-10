class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :overview, :release_date, :inventory
end
