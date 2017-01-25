class CreatAcceptanceCriteria < ActiveRecord::Migration[5.0]
  def change
    create_table :acceptance_criteria do |t|
      t.references :user_stories
      t.string :number, comment: 'AC编号'
      t.string :given, limit: 1024, comment: '给定项'
      t.string :when, limit: 1024, comment: '当用户操作项'
      t.string :than, limit: 1024, comment: '希望看到的结果'
      t.timestamps
    end
  end
end
