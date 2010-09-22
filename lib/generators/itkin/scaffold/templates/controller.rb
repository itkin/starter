class <%= controller_class_name %>Controller < ApplicationController

  def index
    @<%= plural_name %> = <%= class_name %>.search(params[:search]).paginate(:per_page =>10, :page => params[:page])
    render :action => :index
  end

  def show
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end

  def new
    @<%= singular_name %> = <%= class_name %>.new
  end

  def edit
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end

  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%=singular_name%>])
    if @<%= singular_name %>.save
      flash.now[:notice] = "<%= human_name %> a été créé"
      render :action => :index
    else
      flash.now[:warning] = "<%= human_name %> n'a pas pu etre créé"
      render :action => :new
    end
  end

  def update
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    if @<%= singular_name %>.update_attributes(params[:<%=singular_name%>])
      flash.now[:notice] = "<%= human_name %> a été mis à jour"
      render :action => :update
    else
      flash.now[:warning] = "<%= human_name %> n'a pas pu être mis à jour"
      render :action => :edit
    end
  end

  def destroy
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    if @<%= singular_name %>.destroy
      flash.now[:notice] = "<%= human_name %> a été détruit"
      index
    else
      flash.now[:warning] = "<%= human_name %> n'a pas pu être détruit"
      render :text => nil
    end
  end
end
