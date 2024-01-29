# frozen_string_literal: true

# This migration comes from decidim (originally 20180226140756)

class AddVersionToActionLogs < ActiveRecord::Migration[5.1]
  class ActionLog < ApplicationRecord
    self.table_name = :decidim_action_logs
  end

  def up
    add_column :decidim_action_logs, :version_id, :integer
    add_index :decidim_action_logs, :version_id

    ActionLog.find_each do |action_log|
      version_id = action_log.extra.dig("version", "id")
      next unless version_id

      action_log.update_column(:version_id, version_id)
    end
  end

  def down
    remove_column :decidim_action_logs, :version_id
  end
end
