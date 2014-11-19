class CreateUserTags < ActiveRecord::Migration
  def change
    create_table :user_tags do |t|
      t.belongs_to :user
      t.string :tag
      t.timestamps
    end
  end
end
