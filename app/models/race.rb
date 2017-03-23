=begin
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| id            | int(11)      | NO   | PRI | NULL    | auto_increment |
| name          | varchar(256) | YES  |     | NULL    |                |
| seq_id        | bigint(20)   | NO   | UNI | 0       |                |
| logo          | varchar(256) | YES  |     | NULL    |                |
| prize         | int(11)      | NO   |     | 0       |                |
| location      | varchar(256) | YES  |     | NULL    |                |
| begin_date    | date         | YES  | MUL | NULL    |                |
| end_date      | date         | YES  |     | NULL    |                |
| status        | int(11)      | NO   |     | 0       |                |
| created_at    | datetime     | NO   |     | NULL    |                |
| updated_at    | datetime     | NO   |     | NULL    |                |
| ticket_status | varchar(30)  | YES  |     | unsold  |                |
| ticket_price  | int(11)      | YES  |     | 0       |                |
| published     | tinyint(1)   | YES  |     | 0       |                |
+---------------+--------------+------+-----+---------+----------------+
=end
class Race < ApplicationRecord
  # 增加二级查询缓存，缓存过期时间六小时
  second_level_cache(version: 1, expires_in: 6.hours)

  has_one :ticket_info, dependent: :destroy
  has_one :race_desc, dependent: :destroy
  accepts_nested_attributes_for :ticket_info, update_only: true
  accepts_nested_attributes_for :race_desc, update_only: true
  has_many :tickets
  mount_uploader :logo, PhotoUploader
  validates :name, :prize, :logo, presence: true
  enum status: [:unbegin, :go_ahead, :ended, :closed]
  enum ticket_status: {unsold: 'unsold', selling: 'selling', end: 'end', sold_out: 'sold_out'}
  ransacker :status, formatter: proc { |v| statuses[v] }

  scope :seq_desc, -> { order(seq_id: :desc) }
  scope :ticket_sellable, -> { where(ticket_sellable: true) }

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

  def cancel_sell!
    update(ticket_sellable: false)
  end

  def preview_logo
    ENV['CMS_PHOTO_PATH'] + logo.url(:preview)
  end

  def big_logo
    ENV['CMS_PHOTO_PATH'] + logo.url
  end
end
