=begin
+---------------------------+----------+------+-----+---------+----------------+
| Field                     | Type     | Null | Key | Default | Extra          |
+---------------------------+----------+------+-----+---------+----------------+
| id                        | int(11)  | NO   | PRI | NULL    | auto_increment |
| race_id                   | int(11)  | YES  | MUL | NULL    |                |
| total_number              | int(11)  | YES  |     | 0       |                |
| e_ticket_number           | int(11)  | YES  |     | 0       |                |
| entity_ticket_number      | int(11)  | YES  |     | 0       |                |
| e_ticket_sold_number      | int(11)  | YES  |     | 0       |                |
| entity_ticket_sold_number | int(11)  | YES  |     | 0       |                |
| created_at                | datetime | NO   |     | NULL    |                |
| updated_at                | datetime | NO   |     | NULL    |                |
+---------------------------+----------+------+-----+---------+----------------+
=end
class TicketInfo < ApplicationRecord
  belongs_to :race
end
