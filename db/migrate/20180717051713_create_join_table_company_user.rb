class CreateJoinTableCompanyUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :companies, :users do |t|
      t.index [:company_id, :user_id]
      t.index [:user_id, :company_id]
    end
  end
end
