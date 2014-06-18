require 'net/http'
require 'json'

class CalendarLinesController < ApplicationController

  def index

    if params[:update]
      import_data
      redirect_to calendar_lines_url, notice: 'Database was updated successfully.'
    end

    if params[:q].present? && params[:q][:user_id_eq].present?
      @search = CalendarLine.search(params[:q])
      @amount = get_total_amount(params[:q][:user_id_eq])
    else
      @search = CalendarLine.search
    end

    @calendar_lines = @search.result.paginate(:page => params[:page], :per_page => 10)
  end

  private
    def import_data
      data = get_json_data

      data.each do |calendar_line|

        cl = CalendarLine.new
        cl.id = calendar_line['id']
        cl.user_id = calendar_line['user_id']
        cl.date = calendar_line['date']

        bonus_found = false

        calendar_line['fragments'].each do |fragment|
          if fragment['rel_type'] == 'b'
            f = Fragment.new
            f.id = fragment['id']
            f.amount = fragment['amount']

            f.save
            cl.fragments << f

            bonus_found = true
          end
        end
        cl.save if bonus_found
      end

    end

    def get_json_data
      url = 'http://sheltered-refuge-8118.herokuapp.com/all.json'
      response = Net::HTTP.get_response(URI.parse(url))
      buffer = response.body
      JSON.parse(buffer)
    end

    def get_total_amount(user_id)
      amount = 0
      cl_list = CalendarLine.where(:user_id => user_id)
      cl_list.each { |cl| amount += cl.total_amount }
      amount
    end

end
