module RaceHelper
  def in_ticket_manage?
    params[:as] == I18n.t('race.ticket_manage')
  end

  def in_race_list?
    params[:as] == I18n.t('race.list')
  end

  def publish_status_link(race)
    if race.published?
      link_to I18n.t('race.unpublish'), unpublish_admin_race_path(race), method: :post
    else
      link_to I18n.t('race.publish'), publish_admin_race_path(race), method: :post
    end
  end

  def logo_link_to_show(race)
    link_to race.logo.url ? image_tag(race.preview_logo, height: 150, width: 105) : '', admin_race_path(race)
  end

  def race_period(race)
    "#{race.begin_date} 至 #{race.end_date}"
  end

  def format_prize(race)
    "#{race.prize} 元"
  end

  def format_ticket_price(race)
    "RMB #{race.ticket_price}"
  end

  def show_big_logo_link(race)
    link_to image_tag(race.preview_logo, height: 150), race.big_logo, target: '_blank'
  end

  def select_to_status(race)
    select_tag :status, options_for_select(TRANS_RACE_STATUSES, race.status),
               data: { before_val: race.status, id: race.id },
               class: 'ajax_change_status'
  end

  def surplus_ticket(ticket_info)
    content_tag :span, "剩余#{ticket_info.surplus_e_ticket}张电子票，#{ticket_info.surplus_entity_ticket}张实体票",
                class: :red, id: :surplus_ticket
  end

  def select_to_ticket_status(race)
    select_tag :ticket_status, options_for_select(TRANS_TICKET_STATUSES, race.ticket_status),
               data: { before_val: race.ticket_status, id: race.id },
               class: 'ajax_change_status'
  end

  def index_table_actions(source, race)
    source.item I18n.t('active_admin.edit'), edit_admin_race_path(race),
                title: I18n.t('active_admin.edit'),
                class: 'edit_link member_link'
    return if race.published?

    source.item I18n.t('active_admin.delete'), admin_race_path(race),
                title:  I18n.t('active_admin.delete'),
                class:  'delete_link member_link',
                method: :delete,
                data:   { confirm: I18n.t('active_admin.delete_confirmation') }
  end

  def ticket_table_actions(source, race)
    source.item I18n.t('active_admin.edit'), admin_race_ticket_info_path(race, race.ticket_info),
                title: I18n.t('active_admin.edit'),
                class: 'member_link'

    cancel_sell_ticket_link(race)
  end

  def cancel_sell_ticket_link(race)
    link_to I18n.t('race.cancel_sell'), cancel_sell_admin_race_path(race),
            title:  I18n.t('race.cancel_sell'),
            class:  'member_link',
            method: :post,
            data:   { confirm: I18n.t('race.cancel_sell_confirmation') }
  end

  def blind_text(blind)
    "#{blind.small_blind} - #{blind.big_blind}"
  end
end
