#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2020 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.

require 'spec_helper'

describe ::API::V3::Days::DaysAPI,
         content_type: :json,
         type: :request do
  include API::V3::Utilities::PathHelper

  let(:parsed_response) { JSON.parse(last_response.body) }

  current_user { user }

  before do
    create(:week_days)
    get api_v3_paths.days
  end

  context 'for an admin user' do
    let(:user) { build(:admin) }

    nb_days = Time.zone.today.end_of_month.day + Time.zone.today.next_month.end_of_month.day
    it_behaves_like 'API V3 collection response', nb_days, nb_days, 'Day'
  end
end
