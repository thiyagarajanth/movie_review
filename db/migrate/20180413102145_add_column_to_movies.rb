class AddColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :language, :text
    add_column :movies, :type, :text
  end
end
