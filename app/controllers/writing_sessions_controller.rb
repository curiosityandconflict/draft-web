class WritingSessionsController < ApplicationController
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_session, only: [:show, :edit, :update, :destroy, :header_actions]

  # GET /writing_sessions
  # GET /writing_sessions.json
  def index
  end

  # GET /writing_sessions/1
  # GET /writing_sessions/1.json
  def show
    unless can? :read, @session
      redirect_to_home
    end

    @title = 'Show'
  end

  # GET /writing_sessions/new
  def new
    @title = 'Compose'
    @session = WritingSession.new
  end

  # GET /writing_sessions/1/edit
  def edit
    unless can? :update, @session
      redirect_to_home
    end

    @title = 'Compose'
  end

  # POST /writing_sessions
  # POST /writing_sessions.json
  def create
    unless can? :create, WritingSession
      redirect_to_home
    end

    params = session_params
    params[:text] = "<div>#{params[:text]}</div>"

    @session = WritingSession.new params
    @session.user_id = current_user.id
    @session.word_count = get_word_count @session.text

    respond_to do |format|
      if @session.save
        format.html { redirect_to edit_writing_session_path(@session.id), notice: 'Session was successfully created.' }
        format.json { render json: @session, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writing_sessions/1
  # PATCH/PUT /writing_sessions/1.json
  def update
    unless can? :update, @session
      redirect_to_home
    end

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

  # DELETE /writing_sessions/1
  # DELETE /writing_sessions/1.json
  def destroy
    unless can? :destroy, @session
      redirect_to_home
    end

    @session.destroy
    respond_to do |format|
      format.html { redirect_to archive_writing_sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /writing_sessions/word_count
  # GET /writing_sessions/word_count.json
  def word_count
    sum = 0
    word_count_per_day.each { |x| sum += x.total_words }
    @word_count_total = sum

    respond_to do |format|
      format.json { render json: { word_count: sum }, status: :ok }
    end
  end

  # GET /writing_sessions/archive
  # GET /writing_sessions/archive.json
  def archive
    @title = 'Archive'
    @sessions = WritingSession.where(user_id: current_user.id).order(updated_at: :desc)

    sum = 0
    word_count_per_day.each { |x| sum += x.total_words }
    @word_count_total = sum
  end

  # GET /writing_sessions/1/headerActions
  # GET /writing_sessions/1/headerActions.json
  def header_actions
    if params[:id]
      @session = WritingSession.find(params[:id])
    else
      @session = WritingSession.new
    end

    render partial: 'writing_sessions/headerActions'
  end

  private

  def get_word_count(text)
    text.gsub(/\\n/, ' ').gsub('<div>', ' ').gsub('</div>', ' ').split.size
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = WritingSession.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params.require(:session).permit(:text)
  end

  def word_count_per_day
    WritingSession.where(user_id: current_user.id).select('date(created_at) as session_date, sum(word_count) as total_words').group('date(created_at)')
  end
end
