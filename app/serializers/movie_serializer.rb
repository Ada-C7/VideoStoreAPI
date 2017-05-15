class MovieSerializer < ActiveModel::Serializer
  attributes :title, :release_date
  attribute :overview, if: :more_info
  attribute :inventory, if: :more_info
  attribute :available_inventory, if: :more_info

  def more_info
    @instance_options[:more_info]
  end
end
