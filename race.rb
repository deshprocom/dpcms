# +------------+--------------+------+-----+---------+----------------+
# | Field      | Type         | Null | Key | Default | Extra          |
# +------------+--------------+------+-----+---------+----------------+
# | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
# | name       | varchar(256) | YES  |     | NULL    |                |
# | seq_id     | bigint(20)   | NO   |     | 0       |                |
# | logo       | varchar(256) | YES  |     | NULL    |                |
# | prize      | int(11)      | NO   |     | 0       |                |
# | location   | varchar(256) | YES  |     | NULL    |                |
# | begin_date | date         | YES  |     | NULL    |                |
# | end_date   | date         | YES  |     | NULL    |                |
# | status     | int(11)      | NO   |     | 0       |                |
# | created_at | datetime     | NO   |     | NULL    |                |
# | updated_at | datetime     | NO   |     | NULL    |                |
# +------------+--------------+------+-----+---------+----------------+
class Race < ApplicationRecord
  has_one :ticket_info, dependent: :destroy
  has_one :race_desc, dependent: :destroy
  accepts_nested_attributes_for :ticket_info, update_only: true
  accepts_nested_attributes_for :race_desc, update_only: true
  has_many :tickets
  mount_uploader :logo, PhotoUploader

  after_initialize do
    self.begin_date ||= Time.current
    self.end_date ||= Time.current
    ticket_info || build_ticket_info
    race_desc || build_race_desc
  end
  validates :name, :prize, :location, :logo, presence: true
end
