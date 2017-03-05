# +---------------+--------------+------+-----+---------+----------------+
# | Field         | Type         | Null | Key | Default | Extra          |
# +---------------+--------------+------+-----+---------+----------------+
# | id            | int(11)      | NO   | PRI | NULL    | auto_increment |
# | user_uuid     | varchar(32)  | NO   | UNI | NULL    |                |
# | user_name     | varchar(32)  | YES  | UNI | NULL    |                |
# | nick_name     | varchar(32)  | YES  |     | NULL    |                |
# | password      | varchar(32)  | YES  |     | NULL    |                |
# | password_salt | varchar(255) | NO   |     |         |                |
# | gender        | int(11)      | YES  |     | 0       |                |
# | email         | varchar(64)  | YES  | UNI | NULL    |                |
# | mobile        | varchar(16)  | YES  | UNI | NULL    |                |
# | avatar        | varchar(255) | YES  |     | NULL    |                |
# | birthday      | date         | YES  |     | NULL    |                |
# | reg_date      | datetime     | YES  |     | NULL    |                |
# | last_visit    | datetime     | YES  |     | NULL    |                |
# | created_at    | datetime     | NO   |     | NULL    |                |
# | updated_at    | datetime     | NO   |     | NULL    |                |
# +---------------+--------------+------+-----+---------+----------------+

# 用户信息表
class User < ApplicationRecord
  has_one :user_extra
  has_many :purchase_orders
end