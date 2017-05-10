class MovieSerializer < ActiveModel::Serializer
  attributes :title, :overview, :release_date, :inventory
end
