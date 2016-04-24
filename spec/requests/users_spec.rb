# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role_id                :integer
#

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:site_admin_role) { FactoryGirl.create(:role, name: 'site_admin') }
  let(:site_admin_user) { FactoryGirl.create(:user, role: site_admin_role) }

  before(:example) do
    login_as(site_admin_user, scope: :user)
  end

  describe 'GET /users' do
    it 'works' do
      get admin_users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/1' do
    it 'works' do
      get admin_user_path(site_admin_user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/new' do
    it 'works' do
      get new_admin_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/1/edit' do
    it 'works' do
      get edit_admin_user_path(site_admin_user)
      expect(response).to have_http_status(200)
    end
  end
end
