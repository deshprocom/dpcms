
class IndexAsCategory < ActiveAdmin::Component

  def build(page_presenter, collection)
    render 'index', collection: collection
  end

  def self.index_name
    'category'
  end
end

