module RaceHelper
  def publish_status_link(race)
    if race.published?
      link_to I18n.t('race.unpublish'), unpublish_admin_race_path(race), method: :post
    else
      link_to I18n.t('race.publish'), publish_admin_race_path(race), method: :post
    end
  end

  def race_status_with_trans
    RACE_STATUSES.collect { |d| [I18n.t("race.#{d}"), d] }
  end

  def logo_link_to_show(race)
    link_to race.logo.url ? image_tag(race.logo.url(:preview)) : '', admin_race_path(race)
  end

  def race_period(race)
    "#{race.begin_date} 至 #{race.end_date}"
  end

  def format_prize(race)
    "#{race.prize} 元"
  end

  def show_big_logo_link(race)
    link_to image_tag(race.logo.url(:preview)), race.logo.url, target: '_blank'
  end
  def select_to_status(race)
    select_tag :status, options_for_select(race_status_with_trans, race.status),
               data: { before_val: race.status, id: race.id }, class: 'test'
  end

  def index_table_actions(source, race)
    source.item I18n.t('active_admin.edit'), edit_admin_race_path(race), title: I18n.t('active_admin.edit'),
         class: 'edit_link member_link'
    unless race.published?
      source.item I18n.t('active_admin.delete'), admin_race_path(race), title: I18n.t('active_admin.delete'),
           class: 'delete_link member_link',
           method: :delete, data: {confirm: I18n.t('active_admin.delete_confirmation')}
    end
  end
end

