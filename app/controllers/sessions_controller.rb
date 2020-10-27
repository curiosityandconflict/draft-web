class SessionsController < ApplicationController
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_session, only: [:show, :edit, :update, :destroy, :header_actions]

  # GET /sessions
  # GET /sessions.json
  def index
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @title = 'Show'
  end

  # GET /sessions/new
  def new
    @title = 'Compose'
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
    @title = 'Compose'
  end

  # POST /sessions
  # POST /sessions.json
  def create
    params = session_params
    params[:text] = "<div>#{params[:text]}</div>"

    @session = Session.new params
    @session.word_count = get_word_count @session.text

    respond_to do |format|
      if @session.save
        format.html { redirect_to edit_session_path(@session.id), notice: 'Session was successfully created.' }
        format.json { render json: @session, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    text = @session.text + "<div>#{session_params[:text]}</div>"
    word_count = get_word_count text

    respond_to do |format|
      if @session.update(text: text, word_count: word_count)
        format.html { render :edit, notice: 'Session was successfully updated.' }
        format.json { render json: @session, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to archive_sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /sessions/word_count
  # GET /sessions/word_count.json
  def word_count
    sum = 0
    word_count_per_day.each { |x| sum += x.total_words }
    @word_count_total = sum

    respond_to do |format|
      format.json { render json: { word_count: sum }, status: :ok }
    end
  end

  # GET /sessions/archive
  # GET /sessions/archive.json
  def archive
    @title = 'Archive'
    @sessions = Session.all.order(updated_at: :desc)

    sum = 0
    word_count_per_day.each { |x| sum += x.total_words }
    @word_count_total = sum
  end

  # GET /sessions/1/headerActions
  # GET /sessions/1/headerActions.json
  def header_actions
    if params[:id]
      @session = Session.find(params[:id])
    else
      @session = Session.new
    end

    render partial: 'sessions/headerActions'
  end

  private

  def get_word_count(text)
    text.gsub(/\\n/, ' ').gsub('<div>', ' ').gsub('</div>', ' ').split.size
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params.require(:session).permit(:text)
  end

  def word_count_per_day
    Session.select('date(created_at) as session_date, sum(word_count) as total_words').group('date(created_at)')
  end
end
