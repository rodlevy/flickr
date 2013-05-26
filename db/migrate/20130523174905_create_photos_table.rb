class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string      :photo_name
      t.references  :album
      t.string		:file
    end
  end
end
