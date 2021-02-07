class ShortestPathService
  def self.process(start_id, end_id)
    visited = {}
    queue = []

    queue << start_id
    visited[start_id] = :start

    found = false

    while queue.size > 0 && !found
      current_id = queue.shift

      Friendship.where('member_a_id = ? OR member_b_id = ?', current_id, current_id).each do |friendship|
        friend_id = friendship.member_a_id == current_id ? friendship.member_b_id : friendship.member_a_id

        next if visited.include?(friend_id)

        queue << friend_id
        visited[friend_id] = current_id

        found = true if friend_id == end_id
      end
    end

    return nil unless found

    path = [end_id]
    last = end_id

    until last == :start
      last = visited[last]
      path << last unless last == :start
    end

    return path.reverse
  end
end
