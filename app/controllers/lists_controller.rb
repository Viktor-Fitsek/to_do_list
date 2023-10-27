class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  
  include Pagy::Backend
  # GET /lists or /lists.json
  def index
    @lists = current_user.lists
  end

  # GET /lists/1 or /lists/1.json
  def show
    @order = params[:sortirovka] || 'title'
    @dir = params[:napr] || 'asc'
    #SORT/lists
    @items = @list.items
    @items = @items.order(Item.sanitize_sql_for_order("#{@order} #{@dir}"))
    
    #  @items = @list.items.order(titel: :asc, completed: :asc, priority: :asc, deadline: :desc)
    
    #Number1
    #if params[:completed] == 'true'
    #  completed = true
    #else
    #  completed = [false, nil]
    #end

    #Number2
    #completed = if params[:completed] == 'true'
    #  true
    #else
    #  [false, nil]
    #end
    
    #Number3
    #if params[:completed]
    #  completed = params[:completed] == 'true' ? true : [false, nil]
    #  @items = @items.where(completed: completed)
    #end

    @items = if params[:completed] == 'true'
      @completed = true
      @items.where(completed: true)
    elsif params[:completed] == 'false'
      @completed = false
      @items.where(completed: [false, nil])
    else
      @items
    end
    #Pagination
    #page = if params[:page] == nil
    #  1
    #else
    #  params[:page].to_i
    #end
    #@page    = [params[:page].to_i, 1].max
    ## byebug 
    @per_page = (params[:per_page] || 10).to_i
    #@number_of_pages = (@items.size/@per_page.to_f).ceil
    #@items = @items.offset((@page-1)*@per_page).limit(@per_page)

    @pagy, @items = pagy(@items, items: @per_page)
  end
  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = current_user.lists.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title)
    end
end
