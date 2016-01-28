Class.new(Nanoc::Filter) do
  identifier :link_to_commit
  type :text

  # Put this filter before markdown filters
  # requires an item to have following attributes
  # * link_to_commits: true
  # * github_username: username on GitHub
  # * repo: Repository of which the commit is in
  # Put commit in text as #commit_hash, e.g. #12345
  def run(content, params={})
    link_to_commits = item[:link_to_commits] || false
    if !link_to_commits
      return content
    end

    warn "Linking commits"

    github_username = item[:github_username]
    repo = item[:repo]

    if github_username.nil? || repo.nil?
      warn "#{@item.identifier} did not specify 'github_username' or 'repo'"
      return
    end

    content.gsub(/#(\w+)/) do |match|
      commit = match[1..-1] # escape starting #
      link = "https://github.com/#{github_username}/#{repo}/commit/#{commit}"
      text = "##{commit}"
      "<a href=#{link}>#{text}</a>"
    end
  end
end
