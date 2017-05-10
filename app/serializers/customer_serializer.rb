class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count

  # has_many :rentals

#  attribute :age, if: -> {object.age>2}

  #def method_name ex: if you had the owners list & only wante dto show some of the owners
  #"im fuzzy"
  #end

#define a method in the model ie. dog years and then call it as an attribuet in serializer.

end






#rental Serializer
#has_many :customers
#has_many :movies
#define methods for other data we want to include in teh JSON(like to call a method in teh model)
#show data of a ealted resource
