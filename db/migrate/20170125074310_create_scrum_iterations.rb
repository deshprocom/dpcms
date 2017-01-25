class CreateScrumIterations < ActiveRecord::Migration[5.0]
  def change
    create_table :scrum_iterations do |t|
      t.date   :begin_date, comment: '迭代开始时间'
      t.string :days,       comment: '持续天数'
      t.text   :content,    comment: '迭代内容'
      t.timestamps
    end
  end
end
