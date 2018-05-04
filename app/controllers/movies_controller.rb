class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy,:rate]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    # @rating = Rating.where(comment_id: @comment.id, user_id: @current_user.id).first
    # unless @rating
    #   @rating = Rating.create(comment_id: @comment.id, user_id: @current_user.id, score: 0)
    # end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)
    @movie.author_id = current_user.id
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rate
    @rating = @movie.rate(movie_rating_params)
  end

  def upvote 
    @link = Movie.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end  

  def downvote
    @link = Movie.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :avatar)
    end
    def movie_rating_params
      params.require(:ratable_rating).permit(:value)
    end
end
