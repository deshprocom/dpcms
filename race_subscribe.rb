# +------------+----------+------+-----+---------+----------------+
# | Field      | Type     | Null | Key | Default | Extra          |
# +------------+----------+------+-----+---------+----------------+
# | id         | int(11)  | NO   | PRI | NULL    | auto_increment |
# | users_id   | int(11)  | YES  | MUL | NULL    |                |
# | races_id   | int(11)  | YES  | MUL | NULL    |                |
# | created_at | datetime | NO   |     | NULL    |                |
# | updated_at | datetime | NO   |     | NULL    |                |
# +------------+----------+------+-----+---------+----------------+
class RaceSubscribe < ApplicationRecord
end
