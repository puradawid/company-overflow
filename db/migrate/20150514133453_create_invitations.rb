class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :secret
      t.string :email
      t.timestamps null: false
    end
  end
end
