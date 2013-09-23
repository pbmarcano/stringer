require_relative "../models/feed"

class FeedRepository
  MIN_YEAR = 1970

  def self.fetch_by_ids(ids)
    Feed.where(id: ids)
  end

  def self.update_last_fetched(feed, timestamp)
    is_invalid_timestamp = timestamp.nil? ||
      timestamp.year < MIN_YEAR ||
      (feed.last_fetched && timestamp <= feed.last_fetched)

    unless is_invalid_timestamp
      feed.last_fetched = timestamp
      feed.save
    end
  end

  def self.delete(feed_id)
    Feed.destroy(feed_id)
  end

  def self.set_status(status, feed)
    feed.status = status
    feed.save
  end

  def self.list
    Feed.order('lower(name)')
  end
end

