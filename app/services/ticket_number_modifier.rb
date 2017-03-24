module Services
  class TicketNumberModifier
    include Serviceable
    attr_accessor :ticket_info

    def initialize(ticket_info, params)
      self.ticket_info = ticket_info
      @e_ticket_increment      = params[:e_ticket_increment].to_i
      @e_ticket_decrement      = params[:e_ticket_decrement].to_i
      @entity_ticket_increment = params[:entity_ticket_increment].to_i
      @entity_ticket_decrement = params[:entity_ticket_decrement].to_i
    end

    def call
      if race.ticket_status == 'selling'
        return ApiResult.error_result(1, '处于售票中，不允许进行票数更改。请先将状态更改为售票结束。')
      end
      if @e_ticket_increment > 0
        increase_e_ticket
      elsif @e_ticket_decrement > 0
        decrease_e_ticket
      elsif @entity_ticket_increment > 0
        increase_entity_ticket
      elsif @entity_ticket_decrement > 0
        decrease_entity_ticket
      else
        ApiResult.error_result(1, '不能为空或为零')
      end
    end

    def increase_e_ticket
      ticket_info.increment!(:e_ticket_number, @e_ticket_increment)
      race.update(ticket_status: 'selling') if race.ticket_status == 'sold_out'
      ApiResult.success_result
    end

    def decrease_e_ticket
      if ticket_info.surplus_e_ticket < @e_ticket_decrement
        return ApiResult.error_result(1, '减去的票数不允许大于剩余的票数')
      end
      ticket_info.decrement!(:e_ticket_number, @e_ticket_decrement)
      race.update(ticket_status: 'sold_out') if ticket_info.sold_out?
      ApiResult.success_result
    end

    def increase_entity_ticket
      ticket_info.increment!(:entity_ticket_number, @entity_ticket_increment)
      race.update(ticket_status: 'selling') if race.ticket_status == 'sold_out'
      ApiResult.success_result
    end

    def decrease_entity_ticket
      if ticket_info.surplus_entity_ticket < @entity_ticket_decrement
        return ApiResult.error_result(1, '减去的票数不允许大于剩余的票数')
      end
      ticket_info.decrement!(:entity_ticket_number, @entity_ticket_decrement)
      race.update(ticket_status: 'sold_out') if ticket_info.sold_out?
      ApiResult.success_result
    end

    def race
      ticket_info.race
    end
  end
end
