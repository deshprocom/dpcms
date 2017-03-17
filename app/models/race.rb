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
  # 增加二级查询缓存，缓存过期时间六小时
  second_level_cache(version: 1, expires_in: 6.hours)

  has_one :ticket_info, dependent: :destroy
  has_one :race_desc, dependent: :destroy
  accepts_nested_attributes_for :ticket_info, update_only: true
  accepts_nested_attributes_for :race_desc, update_only: true
  has_many :tickets
  mount_uploader :logo, PhotoUploader
  validates :name, :prize, :location, :logo, presence: true
  enum status: [:unbegin, :go_ahead, :ended, :closed]
  ransacker :status, formatter: proc { |v| statuses[v] }

  scope :seq_desc, -> { order(seq_id: :desc) }

  after_initialize do
    self.begin_date ||= Date.current
    self.end_date ||= Date.current
  end

  before_save do
    self.seq_id = Services::RaceSequencer.call(self) if begin_date_changed?
  end

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
