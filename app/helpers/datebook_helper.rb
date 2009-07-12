module DatebookHelper
  def get_all_weekdays
    days = Array.new
    1.upto(7) do |day|
      days << I18n.t('date.abbr_day_names')[day % 7]
    end
    days
  end
end
