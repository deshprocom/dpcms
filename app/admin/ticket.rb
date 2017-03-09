ActiveAdmin.register Ticket do
  menu false
  belongs_to :race, optional: true
end
