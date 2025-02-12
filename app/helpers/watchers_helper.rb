#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2022 the OpenProject GmbH
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
#++

module WatchersHelper
  # Create a link to watch/unwatch object
  #
  # * :replace - a string or array of strings with css selectors that will be updated, whenever the watcher status is changed
  def watcher_link(object, user, options = { replace: '.watcher_link', class: 'watcher_link' })
    options = options.with_indifferent_access
    raise ArgumentError, 'Missing :replace option in options hash' if options['replace'].blank?

    return '' unless user&.logged? && object.respond_to?('watched_by?')

    watched = object.watched_by?(user)

    html_options = options
    path = send(:"#{(watched ? 'unwatch' : 'watch')}_path", object_type: object.class.to_s.underscore.pluralize,
                                                            object_id: object.id,
                                                            replace: options.delete('replace'))
    html_options[:class] = html_options[:class].to_s + ' button'

    method = watched ? :delete : :post

    label = watched ? I18n.t(:button_unwatch) : I18n.t(:button_watch)

    link_to(content_tag(:i, '', class: watched ? 'button--icon icon-watched' : ' button--icon icon-unwatched') + ' ' +
      content_tag(:span, label, class: 'button--text'), path, html_options.merge(method:))
  end
end
