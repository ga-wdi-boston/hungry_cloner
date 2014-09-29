base_repo = ARGV[0]

if base_repo.nil?
  abort("Usage: hungry-cloner account\/repo")
end

repo_name = base_repo.split('/')[1]
pull_requests = Octokit.pull_requests base_repo
`mkdir #{repo_name}`

pull_requests.each do |pull_request|
  pull_user = pull_request[:user][:login]
  `mkdir #{repo_name}/#{pull_user}`
  pr_url = pull_request[:head][:repo][:git_url]
  puts "git clone #{pr_url} #{repo_name}/#{pull_user}"
  `git clone #{pr_url} #{repo_name}/#{pull_user}`
end
