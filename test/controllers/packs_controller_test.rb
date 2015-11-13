require 'test_helper'

class PacksControllerTest < ActionController::TestCase
  setup do
    @pack = packs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pack" do
    assert_difference('Pack.count') do
      post :create, pack: { status: @pack.status, title: @pack.title }
    end

    assert_redirected_to pack_path(assigns(:pack))
  end

  test "should show pack" do
    get :show, id: @pack
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pack
    assert_response :success
  end

  test "should update pack" do
    patch :update, id: @pack, pack: { status: @pack.status, title: @pack.title }
    assert_redirected_to pack_path(assigns(:pack))
  end

  test "should destroy pack" do
    assert_difference('Pack.count', -1) do
      delete :destroy, id: @pack
    end

    assert_redirected_to packs_path
  end
end
