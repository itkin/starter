require 'test_helper'

class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  def setup
    @<%= singular_table_name %> = <%= table_name %>(:one)
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:<%= table_name %>)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_<%= singular_table_name %>
    assert_difference('<%= class_name %>.count') do
      post :create, :<%= singular_table_name %> => @<%= singular_table_name %>.attributes
    end
    assert_response :success
  end

  def test_should_show_<%= singular_table_name %>
    get :show, :id => @<%= singular_table_name %>.to_param
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => @<%= singular_table_name %>.to_param
    assert_response :success
  end

  def test_should_update_<%= singular_table_name %>
    put :update, :id => @<%= singular_table_name %>.to_param, :<%= singular_table_name %> => @<%= singular_table_name %>.attributes
    assert_redirected_to <%= singular_table_name %>_path(assigns(:<%= singular_table_name %>))
  end

  def test_should_destroy_<%= singular_table_name %>
    assert_difference('<%= class_name %>.count', -1) do
      delete :destroy, :id => @<%= singular_table_name %>.to_param
    end
    assert_response :success
  end
end
