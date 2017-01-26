class CreateUserStories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_stories do |t|
      t.references :scrum_iteration
      t.string :name,    comment: '故事名称'
      t.string :number,  comment: '故事编号'
      t.text :introduce, comment: '故事介绍'
      t.integer :score,  comment: '故事比重分数'
      t.string :status,  comment: '故事状态 BACKLOG, TODO, WIP, DONE'
      t.timestamps
    end
  end
end
