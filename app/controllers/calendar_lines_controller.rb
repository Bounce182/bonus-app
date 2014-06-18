require 'net/http'
require 'json'

class CalendarLinesController < ApplicationController
  before_action :set_calendar_line, only: [:show, :edit, :update, :destroy]

  # GET /calendar_lines
  # GET /calendar_lines.json
  def index
    if params[:update]
      import_data
      redirect_to calendar_lines_url, notice: 'Database was updated successfully.'
    end

    @search = CalendarLine.search(params[:q])
    @calendar_lines = @search.result.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /calendar_lines/1
  # GET /calendar_lines/1.json
  def show
  end

  # GET /calendar_lines/new
  def new
    @calendar_line = CalendarLine.new
  end

  # GET /calendar_lines/1/edit
  def edit
  end

  # POST /calendar_lines
  # POST /calendar_lines.json
  def create
    @calendar_line = CalendarLine.new(calendar_line_params)

    respond_to do |format|
      if @calendar_line.save
        format.html { redirect_to @calendar_line, notice: 'Calendar line was successfully created.' }
        format.json { render :show, status: :created, location: @calendar_line }
      else
        format.html { render :new }
        format.json { render json: @calendar_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_lines/1
  # PATCH/PUT /calendar_lines/1.json
  def update
    respond_to do |format|
      if @calendar_line.update(calendar_line_params)
        format.html { redirect_to @calendar_line, notice: 'Calendar line was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar_line }
      else
        format.html { render :edit }
        format.json { render json: @calendar_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_lines/1
  # DELETE /calendar_lines/1.json
  def destroy
    @calendar_line.destroy
    respond_to do |format|
      format.html { redirect_to calendar_lines_url, notice: 'Calendar line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_line
      @calendar_line = CalendarLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_line_params
      params.require(:calendar_line).permit(:user_id, :date)
    end

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
      # Uncomment for local testings
      #contents = File.read("#{Rails.root.join('data.json').to_s}" )
      #JSON.parse(contents)
    end

end
