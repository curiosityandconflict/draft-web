class WritingSessionsController < ApplicationController
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :story
  before_action :writing_session, only: [:show, :edit, :update, :destroy, :header_actions]
  after_action :touch_story, only: [:create, :update, :destroy]
  layout "home", only: [:new, :edit]

  def index
    unless can? :read, @story
      redirect_to_home
    end

    @writing_sessions = @story.writing_sessions.order(updated_at: :desc)
  end

  # GET /writing_sessions/1
  # GET /writing_sessions/1.json
  def show
    unless can? :read, @session
      redirect_to_home
    end
  end

  # GET /writing_sessions/new
  def new
    @title = 'Compose'
    @session = @story.writing_sessions.create(user_id: current_user.id, text: "")

    redirect_to edit_story_writing_session_path(@story, @session.id)
  end

  # GET /writing_sessions/1/edit
  def edit
    unless can? :update, @session
      redirect_to_home
    end
  end

  # POST /writing_sessions
  # POST /writing_sessions.json
  def create
    unless can? :create, WritingSession
      redirect_to_home
    end

    params = session_params
    params[:text] = "<div>#{params[:text]}</div>"

    @session = @story.writing_sessions.new params
    @session.user_id = current_user.id
    @session.word_count = @session.calculate_word_count

    respond_to do |format|
      if @session.save
        format.html { redirect_to edit_story_writing_session_path(@story, @session.id), notice: 'Session was successfully created.', status: :see_other }
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

    @session.text += "<div>#{session_params[:text]}</div>"
    @session.word_count = @session.calculate_word_count

    respond_to do |format|
      if @session.save
        format.html { redirect_to edit_story_writing_session_path(@story, @session.id), status: :see_other }
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
      format.html { redirect_to story_path(@story), notice: 'Session was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /writing_sessions/word_count
  # GET /writing_sessions/word_count.json
  # def word_count
  #   sum = 0
  #   word_count_per_day.each { |x| sum += x.total_words }
  #   @word_count_total = sum

  #   respond_to do |format|
  #     format.json { render json: { word_count: sum }, status: :ok }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def writing_session
    @session = @story.writing_sessions.find(params[:id])
  end

  def story
    @story = current_user.stories.find(params[:story_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to_home
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params.require(:writing_session).permit(:text)
  end

  def word_count_per_day
    WritingSession.where(user_id: current_user.id).select('date(created_at) as session_date, sum(word_count) as total_words').group('date(created_at)')
  end

  def touch_story
    @story.try(:touch)
  end
end
