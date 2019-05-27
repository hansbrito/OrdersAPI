class CreateJoinTablePermissionProfile < ActiveRecord::Migration[5.2]
  def change
    create_join_table :permissions, :profiles do |t|
      t.index [:permission_id, :profile_id]
      t.index [:profile_id, :permission_id]

      t.timestamps
    end
  end
end
