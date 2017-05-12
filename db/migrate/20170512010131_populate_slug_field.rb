class PopulateSlugField < ActiveRecord::Migration[5.0]
  def change
    Movie.all.each do |m|
      m.slug = m.title.parameterize
      m.save!
    end
  end
end
