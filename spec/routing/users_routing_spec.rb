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

RSpec.describe Admin::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: admin_users_path)
        .to route_to('admin/users#index', locale: 'en')
    end

    it 'routes to #new' do
      expect(get: new_admin_user_path)
        .to route_to('admin/users#new', locale: 'en')
    end

    it 'routes to #show' do
      expect(get: admin_user_path(:en, 1))
        .to route_to('admin/users#show', id: '1', locale: 'en')
    end

    it 'routes to #edit' do
      expect(get: edit_admin_user_path(:en, 1))
        .to route_to('admin/users#edit', id: '1', locale: 'en')
    end

    it 'routes to #create' do
      expect(post: admin_users_path)
        .to route_to('admin/users#create', locale: 'en')
    end

    it 'routes to #update' do
      expect(put: admin_user_path(:en, 1))
        .to route_to('admin/users#update', id: '1', locale: 'en')
    end

    it 'routes to #destroy' do
      expect(delete: admin_user_path(:en, 1))
        .to route_to('admin/users#destroy', id: '1', locale: 'en')
    end
  end
end
