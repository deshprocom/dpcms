ActiveAdmin.register_page 'Dashboard' do
  # menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  menu false
  content title: proc { I18n.t('active_admin.dashboard') } do
    h3 '以下图表数据每小时更新一次', style: 'text-align: center; padding: 20px'

    columns do
      column do
        panel '最近一周新增app用户数' do
          ul do
            line_chart recent_users_chart_data
          end
        end
      end

      column do
        panel '最近八周新增app用户数' do
          ul do
            column_chart recent_weeks_users_chart_data
          end
        end
      end
    end
  end # content
end
