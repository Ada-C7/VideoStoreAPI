class DetailedMovieSerializer < ActiveModel::Serializer
    attributes :title, :release_date, :overview, :inventory
end
